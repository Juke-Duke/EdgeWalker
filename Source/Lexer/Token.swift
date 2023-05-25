struct Token : Codable
{
    let Kind: TokenKind

    let Value: String

    let Location: String
}
