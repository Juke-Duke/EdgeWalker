extension Parser
{
    static let BindingOperatorGroup: Set<TokenKind> = [
        .NullableOperator,
        .LogicalNotOperator
    ]

    static let UnaryPostfixOperatorGroup: Set<TokenKind> = [
        .DotOperator,
        .OpenParenthesis,
        .OpenBracket
    ]

    static let UnaryPrefixOperatorGroup: Set<TokenKind> = [
        .LogicalNotOperator,
        .PlusOperator,
        .MinusOperator,
        .BitwiseNotOperator
    ]

    static let MultiplicativeOperatorGroup: Set<TokenKind> = [
        .MultiplyOperator,
        .DivideOperator,
        .ModuloOperator,
    ]

    static let AdditiveOperatorGroup: Set<TokenKind> = [
        .PlusOperator,
        .MinusOperator
    ]

    static let BitwiseShiftOperatorGroup: Set<TokenKind> = [
        .BitwiseLeftShiftOperator,
        .BitwiseRightShiftOperator
    ]

    static let BitwiseAndOperatorGroup: Set<TokenKind> = [
        .BitwiseAndOperator
    ]

    static let BitwiseXorOperatorGroup: Set<TokenKind> = [
        .BitwiseXorOperator
    ]

    static let BitwiseOrOperatorGroup: Set<TokenKind> = [
        .BitwiseOrOperator
    ]

    static let RelationalOperatorGroup: Set<TokenKind> = [
        .LessThanOperator,
        .LessThanOrEqualOperator,
        .GreaterThanOperator,
        .GreaterThanOrEqualOperator
    ]

    static let EqualityOperatorGroup: Set<TokenKind> = [
        .EqualOperator,
        .NotEqualOperator
    ]

    static let LogicalAndOperatorGroup: Set<TokenKind> = [
        .LogicalAndOperator
    ]

    static let LogicalOrOperatorGroup: Set<TokenKind> = [
        .LogicalOrOperator
    ]

    static let NullReduceOperatorGroup: Set<TokenKind> = [
        .NullReduceOperator
    ]

    static let RangeOperatorGroup: Set<TokenKind> = [
        .InclusiveRangeOperator,
        .ExclusiveRangeOperator
    ]

    static let AssignmentOperatorGroup: Set<TokenKind> = [
        .AssignOperator,
        .PlusAssignOperator,
        .MinusAssignOperator,
        .MultiplyAssignOperator,
        .DivideAssignOperator,
        .ModuloAssignOperator,
        .PowerAssignOperator,
        .BitwiseAndAssignOperator,
        .BitwiseOrAssignOperator,
        .BitwiseXorAssignOperator,
        .BitwiseLeftShiftAssignOperator,
        .BitwiseRightShiftAssignOperator
    ]
}
