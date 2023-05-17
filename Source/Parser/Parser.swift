class Parser
{
    var lexer: Lexer

    var lookAhead: Token?

    init(source: String)
    {
        lexer = Lexer(source: source)
        lookAhead = lexer.NextToken()
    }

    static func Parse(source: String) throws -> Expression
    {
        var parser: Parser = Parser(source: source)
        return try parser.VariableDeclaration()
    }

    func Expression() throws -> Expression {
        try Assignment()
    }

    func ConsumeToken(kind: TokenKind) throws -> Token
    {
        guard let token: Token = lookAhead else {
            throw SyntaxError(
                location: lookAhead?.Location,
                message: "Unexpected symbol \(lookAhead?.Value ?? "")"
            )
        }

        guard token.Kind != .EndOfFile else {
            throw SyntaxError(
                location: token.Location,
                message: "Unexpected end of file"
            )
        }

        guard kind == token.Kind else {
            throw SyntaxError(
                location: token.Location,
                message: "Unexpected token \(token.Kind) found, expected \(kind.rawValue)"
            )
        }

        lookAhead = lexer.NextToken()

        return token
    }
}
