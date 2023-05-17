extension Parser
{
    func Primary() throws -> Expression {
        switch lookAhead?.Kind
        {
            case .OpenParenthesis:
                return try .ParenthesizedExpression(
                    OpenParenthesisToken: ConsumeToken(kind: .OpenParenthesis),
                    Expression: Assignment(),
                    CloseParenthesisToken: ConsumeToken(kind: .CloseParenthesis)
                )

            case .Identifier:
                return try .IdentifierExpression(IdentifierToken: ConsumeToken(kind: .Identifier))

            default:
                return try Literal()
        }
    }

    func UnaryPostfix() throws -> Expression
    {
        var operandExpression = try Primary()

        var bindingOperatorToken = nil as Token?

        if let bindingOperatorTokenKind = lookAhead?.Kind,
            Parser.BindingOperatorGroup.contains(bindingOperatorTokenKind) {
            bindingOperatorToken = try ConsumeToken(kind: bindingOperatorTokenKind)
        }

        while let unaryPostfixOperatorTokenKind = lookAhead?.Kind,
            Parser.UnaryPostfixOperatorGroup.contains(unaryPostfixOperatorTokenKind)
        {
            switch unaryPostfixOperatorTokenKind
            {
                case .DotOperator:
                    operandExpression = try .MemberAccessExpression(
                        OperandExpression: operandExpression,
                        BindingOperator: bindingOperatorToken,
                        DotOperatorToken: ConsumeToken(kind: .DotOperator),
                        MemberIdentifierToken: ConsumeToken(kind: .Identifier)
                    )

                case .OpenParenthesis:
                    operandExpression = try .InvocationExpression(
                        OperandExpression: operandExpression,
                        BindingOperator: bindingOperatorToken,
                        OpenParenthesisToken: ConsumeToken(kind: .OpenParenthesis),
                        ArgumentExpressions: Arguments(),
                        CloseParenthesisToken: ConsumeToken(kind: .CloseParenthesis)
                    )

                case .OpenBracket:
                    operandExpression = try .IndexerExpression(
                        OperandExpression: operandExpression,
                        BindingOperator: bindingOperatorToken,
                        OpenBracketToken: ConsumeToken(kind: .OpenBracket),
                        ArgumentExpressions: Arguments(),
                        CloseBracketToken: ConsumeToken(kind: .CloseBracket)
                    )

                default:
                    throw SyntaxError(
                        location: lookAhead?.Location,
                        message: "Unexpected symbol"
                    )
            }
        }

        return operandExpression
    }

    func UnaryPrefix() throws -> Expression
    {
        guard let operatorTokenKind = lookAhead?.Kind else {
            return try UnaryPostfix()
        }

        guard Parser.UnaryPrefixOperatorGroup.contains(operatorTokenKind) else {
            return try UnaryPostfix()
        }

        return try.UnaryExpression(
            OperatorToken: ConsumeToken(kind: operatorTokenKind),
            Expression: UnaryPrefix()
        )
    }

    func Exponentiation() throws -> Expression
    {
        var baseExpression = try UnaryPrefix()

        if lookAhead?.Kind != .PowerOperator {
            return baseExpression
        }

        return try .BinaryExpression(
            LeftExpression: baseExpression,
            OperatorToken: ConsumeToken(kind: .PowerOperator),
            RightExpression: Exponentiation()
        )
    }

    func Multiplicative() throws -> Expression {
        try Binary(
            operatorGroup: Parser.MultiplicativeOperatorGroup,
            higherPrecedenceOperation: Exponentiation
        )
    }

    func Additive() throws -> Expression {
        try Binary(
            operatorGroup: Parser.AdditiveOperatorGroup,
            higherPrecedenceOperation: Multiplicative
        )
    }

    func BitwiseShift() throws -> Expression {
        try Binary(
            operatorGroup: Parser.BitwiseShiftOperatorGroup,
            higherPrecedenceOperation: Additive
        )
    }

    func BitwiseAnd() throws -> Expression {
        try Binary(
            operatorGroup: Parser.BitwiseAndOperatorGroup,
            higherPrecedenceOperation: BitwiseShift
        )
    }

    func BitwiseXor() throws -> Expression {
        try Binary(
            operatorGroup: Parser.BitwiseXorOperatorGroup,
            higherPrecedenceOperation: BitwiseAnd
        )
    }

    func BitwiseOr() throws -> Expression {
        try Binary(
            operatorGroup: Parser.BitwiseOrOperatorGroup,
            higherPrecedenceOperation: BitwiseXor
        )
    }

    func Relational() throws -> Expression {
        try Binary(
            operatorGroup: Parser.RelationalOperatorGroup,
            higherPrecedenceOperation: BitwiseOr
        )
    }

    func Equality() throws -> Expression {
        try Binary(
            operatorGroup: Parser.EqualityOperatorGroup,
            higherPrecedenceOperation: Relational
        )
    }

    func LogicalAnd() throws -> Expression {
        try Binary(
            operatorGroup: Parser.LogicalAndOperatorGroup,
            higherPrecedenceOperation: Equality
        )
    }

    func LogicalOr() throws -> Expression {
        try Binary(
            operatorGroup: Parser.LogicalOrOperatorGroup,
            higherPrecedenceOperation: LogicalAnd
        )
    }

    func NullReduce() throws -> Expression
    {
        var nullableExpression = try LogicalOr()

        if lookAhead?.Kind != .NullReduceOperator {
            return nullableExpression
        }

        return try .BinaryExpression(
            LeftExpression: nullableExpression,
            OperatorToken: ConsumeToken(kind: .NullReduceOperator),
            RightExpression: NullReduce()
        )
    }

    func Binary(
        operatorGroup: Set<TokenKind>,
        higherPrecedenceOperation: () throws -> Expression
    ) throws -> Expression
    {
        var leftExpression = try higherPrecedenceOperation()

        while let operatorTokenKind = lookAhead?.Kind,
            operatorGroup.contains(operatorTokenKind)
        {
            leftExpression = try .BinaryExpression(
                LeftExpression: leftExpression,
                OperatorToken: ConsumeToken(kind: operatorTokenKind),
                RightExpression: higherPrecedenceOperation()
            )
        }

        return leftExpression;
    }

    func Range() throws -> Expression
    {
        var leftBoundExpression = nil as Expression?

        if let rangeOperatorKind = lookAhead?.Kind,
            !Parser.RangeOperatorGroup.contains(rangeOperatorKind) {
            leftBoundExpression = try NullReduce()
        }

        var rangeOperator = nil as Token?

        if let rangeOperatorKind = lookAhead?.Kind,
            Parser.RangeOperatorGroup.contains(rangeOperatorKind) {
            rangeOperator = try ConsumeToken(kind: rangeOperatorKind)
        }

        switch rangeOperator?.Kind
        {
            case .InclusiveRangeOperator:
                return try .RangeExpression(
                    LeftBoundExpression: leftBoundExpression,
                    RangeOperatorToken: rangeOperator!,
                    RightBoundExpression: try? NullReduce()
                )

            case .ExclusiveRangeOperator:
                return try .RangeExpression(
                    LeftBoundExpression: leftBoundExpression,
                    RangeOperatorToken: rangeOperator!,
                    RightBoundExpression: try NullReduce()
                )

            default:
                return leftBoundExpression!
        }
    }

    func Assignment() throws -> Expression
    {
        let leftValueExpression = try Range()

        if let assignmentOperatorTokenKind = lookAhead?.Kind,
            !Parser.AssignmentOperatorGroup.contains(assignmentOperatorTokenKind) {
            return leftValueExpression
        }

        return try .AssignmentExpression(
            LeftValueExpression: leftValueExpression,
            AssignmentOperatorToken: ConsumeToken(kind: lookAhead!.Kind),
            InitializerExpression: Range()
        )
    }

    func Arguments() throws -> [Expression]
    {
        var argumentExpressions = [] as [Expression]

        guard lookAhead?.Kind != .CloseParenthesis else {
            return argumentExpressions
        }

        var identifierToken = try ConsumeToken(kind: .Identifier)

        var colonToken = try ConsumeToken(kind: .Colon)

        var expression = try Assignment()

        while lookAhead?.Kind == .Comma {
            argumentExpressions.append(
                try .ArgumentExpression(
                    IdentifierToken: identifierToken,
                    ColonToken: colonToken,
                    Expression: expression,
                    CommaToken: ConsumeToken(kind: .Comma)
                )
            )

            identifierToken = try ConsumeToken(kind: .Identifier)

            colonToken = try ConsumeToken(kind: .Colon)

            expression = try Assignment()
        }

        argumentExpressions.append(
            try .ArgumentExpression(
                IdentifierToken: identifierToken,
                ColonToken: colonToken,
                Expression: expression,
                CommaToken: nil
            )
        )

        return argumentExpressions
    }
}
