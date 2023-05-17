indirect enum Expression : Codable
{
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

    case IdentifierExpression(IdentifierToken: Token)

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

    case RangeExpression(
        LeftBoundExpression: Expression?,
        RangeOperatorToken: Token,
        RightBoundExpression: Expression?
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

    case AttributeExpression(
        AtSignToken: Token,
        IdentifierToken: Token,
        OpenParenthesisToken: Token?,
        ArgumentExpressions: [Expression],
        CloseParenthesisToken: Token?
    )

    case VariableDeclarationExpression(
        VarKeywordToken: Token,
        IdentifierToken: Token,
        ColonToken: Token?,
        TypeIdentifierToken: Token?,
        AssignOperatorToken: Token?,
        InitializerExpression: Expression?,
        SemicolonToken: Token
    )

    case VariableDeconstructionDeclarationExpression(
        VarKeywordToken: Token,
        OpenParenthesisToken: Token,
        IdentifierTokens: [Token],
        CloseParenthesisToken: Token,
        AssignOperatorToken: Token?,
        TupleLiteralExpression: Expression
    )

    case ConstantDeclarationExpression(
        ConstKeywordToken: Token,
        IdentifierToken: Token,
        ColonToken: Token?,
        TypeIdentifierToken: Token?,
        AssignOperatorToken: Token,
        InitializerExpression: Expression,
        SemicolonToken: Token
    )
}
