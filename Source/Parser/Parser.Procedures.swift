extension Parser
{
    func ProcedureDeclaration() throws -> Expression
    {
        let procedureKeywordToken = try ConsumeToken(kind: .ProcKeyword)

        let identifierToken = try ConsumeToken(kind: .Identifier)

        if let openAngleBracketToken = lookAhead?.Kind,
            openAngleBracketToken == .LessThanOperator {
            return try .ProcedureDeclarationExpression(
                ProcKeywordToken: procedureKeywordToken,
                IdentifierToken: identifierToken,
                OpenAngleBracketToken: ConsumeToken(kind: .LessThanOperator),
                TypeParameters: [Expression],
                CloseAngleBracketToken: Token?,
                OpenParenthesisToken: Token,
                Parameters: [Expression],
                CloseParenthesisToken: Token,
                LambdaOperatorToken: Token?,
                Expression: Expression?
            )
        }
    }
}
