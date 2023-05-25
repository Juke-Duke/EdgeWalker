indirect enum Expression : Codable
{
    case Program(
        EdgeDeclarations: [Expression],
        AliasDeclarations: [Expression],
        ProcedureBody: [Expression]
    )

    case Library(
        EdgeDeclarations: [Expression],
        AliasDeclarations: [Expression],
        ModuleDeclarations: [Expression]
    )

    case EdgeDeclaration(
        EdgeKeywordToken: Token,
        Path: Expression,
        SemicolonToken: Token
    )

    case AliasDeclaration(
        AliasKeywordToken: Token,
        IdentifierToken: Token,
        AssignOperatorToken: Token,
        Path: Expression,
        SemicolonToken: Token
    )

    case Path(
        ModuleFullPath: [Expression],
        DotOperatorToken: Token?,
        IdentifierToken: Token,
        OpenAngleBracketToken: Token?,
        Commas: [Token],
        CloseAngleBracketToken: Token?
    )

    case Identifier(IdentifierToken: Token)

    case ModulePath(
        IdentifierToken: Token,
        SlashToken: Token?
    )

    case TypePath(
        ModuleFullPath: [Expression],
        DotOperatorToken: Token?,
        IdentifierToken: Token,
        OpenAngleBracketToken: Token?,
        TypeArguments: [Token],
        CloseAngleBracketToken: Token?
    )

    case Type(
        IdentifierToken: Token,
        OpenAngleBracketToken: Token?,
        TypeArguments: [Expression],
        CloseAngleBracketToken: Token?
    )

    case LiteralExpression(LiteralToken: Token)

    case CollectionLiteralExpression(
        OpenToken: Token,
        Expressions: [Expression],
        CloseToken: Token
    )

    case ElementExpression(
        Expression: Expression,
        CommaToken: Token?
    )

    case KeyValuePairExpression(
        KeyExpression: Expression?,
        ColonToken: Token,
        ValueExpression: Expression?,
        CommaToken: Token?
    )

    case RangeLiteral(
        LeftBoundExpression: Expression?,
        RangeOperatorToken: Token,
        RightBoundExpression: Expression?
    )

    case BinaryExpression(
        LeftExpression: Expression,
        OperatorToken: Token,
        RightExpression: Expression
    )

    case UnaryExpression(
        OperatorToken: Token,
        Expression: Expression
    )

    case MemberAccessExpression(
        OperandExpression: Expression,
        BindingOperator: Token?,
        DotOperatorToken: Token,
        MemberIdentifierToken: Token
    )

    case InvocationExpression(
        OperandExpression: Expression,
        BindingOperator: Token?,
        OpenParenthesisToken: Token,
        ArgumentExpressions: [Expression],
        CloseParenthesisToken: Token
    )

    case IndexerExpression(
        OperandExpression: Expression,
        BindingOperator: Token?,
        OpenBracketToken: Token,
        ArgumentExpressions: [Expression],
        CloseBracketToken: Token
    )

    case ExclusiveRangeExpression(
        LeftBoundExpression: Expression?,
        ExlusiveRangeOperator: Token,
        ExlusiveRightBoundExpression: Expression
    )

    case AssignmentExpression(
        LeftValueExpression: Expression,
        AssignmentOperatorToken: Token,
        InitializerExpression: Expression
    )

    case ParenthesizedExpression(
        OpenParenthesisToken: Token,
        Expression: Expression,
        CloseParenthesisToken: Token
    )

    case ArgumentExpression(
        IdentifierToken: Token,
        ColonToken: Token,
        Expression: Expression,
        CommaToken: Token?
    )

    case Attribute(
        AtSignToken: Token,
        IdentifierToken: Token,
        OpenParenthesisToken: Token?,
        ArgumentExpressions: [Expression],
        CloseParenthesisToken: Token?
    )

    case VariableDeclaration(
        VarKeywordToken: Token,
        IdentifierToken: Token,
        ColonToken: Token?,
        TypeIdentifierToken: Token?,
        AssignOperatorToken: Token?,
        InitializerExpression: Expression?,
        SemicolonToken: Token
    )

    case VariableDeconstruction(
        VarKeywordToken: Token,
        OpenParenthesisToken: Token,
        IdentifierTokens: [Token],
        CloseParenthesisToken: Token,
        AssignOperatorToken: Token?,
        TupleLiteralExpression: Expression
    )

    case ConstantDeclaration(
        ConstKeywordToken: Token,
        IdentifierToken: Token,
        ColonToken: Token?,
        TypeIdentifierToken: Token?,
        AssignOperatorToken: Token,
        InitializerExpression: Expression,
        SemicolonToken: Token
    )

    case ProcedureDeclaration(
        Attributes: [Expression],
        ProcKeywordToken: Token,
        IdentifierToken: Token,
        OpenAngleBracketToken: Token?,
        TypeParameters: [Expression],
        CloseAngleBracketToken: Token?,
        OpenParenthesisToken: Token,
        Parameters: [Expression],
        CloseParenthesisToken: Token,
        LambdaOperatorToken: Token?,
        Expression: Expression?
    )

    case TypeParameter(
        Attributes: [Expression],
        IdentifierToken: Token,
        ColonToken: Token?,
        TypeCnstraints: [Expression]
    )
}
