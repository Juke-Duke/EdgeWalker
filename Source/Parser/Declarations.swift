indirect enum Declaration
{
    case Edge(
        EdgeKeyword: Token,
        Semicolon: Token
    )

    case Alias(
        AliasKeyword: Token,
        Identifier: Token,
        AssignOperator: Token
    )

    case Module(
        Attributes: [Declaration],
        ModuleKeyword: Token,
        Identifier: Token,
        
    )
}
