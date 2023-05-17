extension Parser
{
    func VariableDeclaration() throws -> Expression
    {
        let varKeywordToken = try ConsumeToken(kind: .VarKeyword)

        var identifierToken = nil as Token?

        switch (lookAhead?.Kind) {
            case .Underscore:
                identifierToken = try ConsumeToken(kind: .Underscore)

            default:
                identifierToken = try ConsumeToken(kind: .Identifier)
        }

        var colonToken = nil as Token?

        var typeIdentifierToken = nil as Token?

        if lookAhead?.Kind == .Colon
        {
            colonToken = try ConsumeToken(kind: .Colon)
            typeIdentifierToken = try ConsumeToken(kind: .Identifier)
        }

        var assignOperatorToken = nil as Token?

        var initializerExpression = nil as Expression?

        if lookAhead?.Kind == .AssignOperator
        {
            assignOperatorToken = try ConsumeToken(kind: .AssignOperator)
            initializerExpression = try Expression()
        }

        if typeIdentifierToken == nil && initializerExpression == nil {
            throw SyntaxError(
                location: identifierToken!.Location,
                message: "Variable declaration must have a declared type if no initializer is provided"
            )
        }

        return try .VariableDeclarationExpression(
            VarKeywordToken: varKeywordToken,
            IdentifierToken: identifierToken!,
            ColonToken: colonToken,
            TypeIdentifierToken: typeIdentifierToken,
            AssignOperatorToken: assignOperatorToken,
            InitializerExpression: initializerExpression,
            SemicolonToken: ConsumeToken(kind: .Semicolon)
        )
    }

    func ConstantDeclaration() throws -> Expression
    {
        let constKeywordToken = try ConsumeToken(kind: .ConstKeyword)

        var identifierToken = nil as Token?

        switch (lookAhead?.Kind) {
            case .Underscore:
                identifierToken = try ConsumeToken(kind: .Underscore)

            default:
                identifierToken = try ConsumeToken(kind: .Identifier)
        }

        var colonToken = nil as Token?

        var typeIdentifierToken = nil as Token?

        if lookAhead?.Kind == .Colon
        {
            colonToken = try ConsumeToken(kind: .Colon)
            typeIdentifierToken = try ConsumeToken(kind: .Identifier)
        }

        return try .ConstantDeclarationExpression(
            ConstKeywordToken: constKeywordToken,
            IdentifierToken: identifierToken!,
            ColonToken: colonToken,
            TypeIdentifierToken: typeIdentifierToken,
            AssignOperatorToken: ConsumeToken(kind: .AssignOperator),
            InitializerExpression: Expression(),
            SemicolonToken: ConsumeToken(kind: .Semicolon)
        )
    }
}
