extension Parser
{
    func Attribute() throws -> Expression
    {
        let atSignToken = try ConsumeToken(kind: .AtSign)

        let identifierToken = try ConsumeToken(kind: .Identifier)

        if lookAhead?.Kind != .OpenParenthesis {
            return try .AttributeExpression(
                AtSignToken: atSignToken,
                IdentifierToken: identifierToken,
                OpenParenthesisToken: nil,
                ArgumentExpressions: [],
                CloseParenthesisToken: nil
            )
        }

        return try .AttributeExpression(
            AtSignToken: atSignToken,
            IdentifierToken: identifierToken,
            OpenParenthesisToken: ConsumeToken(kind: .OpenParenthesis),
            ArgumentExpressions: Arguments(),
            CloseParenthesisToken: ConsumeToken(kind: .CloseParenthesis)
        )
    }
}
