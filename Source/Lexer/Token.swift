struct Token : Codable, Hashable
{
    let Kind: TokenKind

    let Value: String

    let Location: String
}
