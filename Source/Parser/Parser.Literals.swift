extension Parser
{
    func Literal() throws -> Expression {
        switch lookAhead?.Kind
        {
            case .NullLiteral:
                return try .LiteralExpression(
                    LiteralToken: ConsumeToken(kind: .NullLiteral)
                )

            case .BooleanLiteral:
                return try .LiteralExpression(
                    LiteralToken: ConsumeToken(kind: .BooleanLiteral)
                )

            case .NumericLiteral:
                return try .LiteralExpression(
                    LiteralToken: ConsumeToken(kind: .NumericLiteral)
                )

            case .CharacterLiteral:
                return try .LiteralExpression(
                    LiteralToken: ConsumeToken(kind: .CharacterLiteral)
                )

            case .TextLiteral:
                return try .LiteralExpression(
                    LiteralToken: ConsumeToken(kind: .TextLiteral)
                )

            case .RawTextLiteral:
                return try .LiteralExpression(
                    LiteralToken: ConsumeToken(kind: .RawTextLiteral)
                )

            case .OpenBracket:
                return try .CollectionLiteralExpression(
                    OpenToken: ConsumeToken(kind: .OpenBracket),
                    Expressions: Elements(),
                    CloseToken: ConsumeToken(kind: .CloseBracket)
                )

            case .OpenBrace:
                return try MapOrSetLiteral()

            case .OpenParenthesis:
                return try .CollectionLiteralExpression(
                    OpenToken: ConsumeToken(kind: .OpenParenthesis),
                    Expressions: Elements(),
                    CloseToken: ConsumeToken(kind: .CloseParenthesis)
                )

            default:
                throw SyntaxError(
                    location: lookAhead?.Location,
                    message: "Expected a literal, found '\(lookAhead?.Kind.rawValue ?? "")'"
                )
        }
    }

    func MapOrSetLiteral() throws -> Expression
    {
        let openBraceToken: Token = try ConsumeToken(kind: .OpenBrace)

        guard lookAhead?.Kind != .Colon else {
            return try .CollectionLiteralExpression(
                OpenToken: openBraceToken,
                Expressions: [
                    .KeyValuePairExpression(
                        KeyExpression: nil,
                        ColonToken: ConsumeToken(kind: .Colon),
                        ValueExpression: nil,
                        CommaToken: nil
                    )
                ],
                CloseToken: ConsumeToken(kind: .CloseBrace)
            )
        }

        guard lookAhead?.Kind != .CloseBrace else {
            return try .CollectionLiteralExpression(
                OpenToken: openBraceToken,
                Expressions: [],
                CloseToken: ConsumeToken(kind: .CloseBrace)
            )
        }

        let expression = try Expression()

        if lookAhead?.Kind == .Colon {
            return try .CollectionLiteralExpression(
                OpenToken: openBraceToken,
                Expressions: KeyValuePairs(firstKeyExpression: expression),
                CloseToken: ConsumeToken(kind: .CloseBrace)
            )
        }
        else {
            return try .CollectionLiteralExpression(
                OpenToken: openBraceToken,
                Expressions: Elements(firstElementExpression: expression),
                CloseToken: ConsumeToken(kind: .CloseBrace)
            )
        }
    }

    func Elements(firstElementExpression: Expression? = nil) throws -> [Expression]
    {
        var elementExpressions = [] as [Expression]

        guard firstElementExpression != nil || lookAhead?.Kind != .CloseBracket else {
            return elementExpressions
        }

        var expression = firstElementExpression == nil
            ? try Expression()
            : firstElementExpression!

        while lookAhead?.Kind == .Comma
        {
            elementExpressions.append(
                .ElementExpression(
                    Expression: expression,
                    CommaToken: try ConsumeToken(kind: .Comma)
                )
            )

            expression = try Expression()
        }

        elementExpressions.append(
            .ElementExpression(
                Expression: expression,
                CommaToken: nil
            )
        )

        return elementExpressions
    }

    func KeyValuePairs(firstKeyExpression: Expression) throws -> [Expression]
    {
        var keyValuePairsExpressions = [] as [Expression]

        var keyExpression = firstKeyExpression

        var colonToken = try ConsumeToken(kind: .Colon)

        var valueExpression = try Expression()

        while lookAhead?.Kind == .Comma
        {
            keyValuePairsExpressions.append(
                try .KeyValuePairExpression(
                    KeyExpression: keyExpression,
                    ColonToken: colonToken,
                    ValueExpression: valueExpression,
                    CommaToken: ConsumeToken(kind: .Comma)
                )
            )

            keyExpression = try Expression()

            colonToken = try ConsumeToken(kind: .Colon)

            valueExpression = try Expression()
        }

        keyValuePairsExpressions.append(
            .KeyValuePairExpression(
                KeyExpression: keyExpression,
                ColonToken: colonToken,
                ValueExpression: valueExpression,
                CommaToken: nil
            )
        )

        return keyValuePairsExpressions
    }
}
