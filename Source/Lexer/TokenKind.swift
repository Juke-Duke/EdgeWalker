enum TokenKind : String, Codable
{
    // Trivials
    case Whitespace
    case EndOfLine
    case SingleLineComment
    case MultiLineComment
    case DocumentationComment
    case EndOfFile

    // Symbols
    case Semicolon
    case Colon
    case Comma
    case OpenParenthesis
    case CloseParenthesis
    case OpenBrace
    case CloseBrace
    case OpenBracket
    case CloseBracket
    case AtSign
    case Underscore

    // Literals
    case NullLiteral
    case BooleanLiteral
    case NumericLiteral
    case CharacterLiteral
    case TextLiteral
    case RawTextLiteral

    // Keywords - Declaration
    case EdgeKeyword
    case VarKeyword
    case ConstKeyword
    case ProcKeyword
    case TypeKeyword
    case ExtendKeyword
    case InterfaceKeyword
    case UnionKeyword
    case EnumKeyword
    case ModuleKeyword
    case AsyncKeyword

    // Keywords - Control Flow
    case IfKeyword
    case ElseKeyword
    case MatchKeyword
    case ForKeyword
    case WhileKeyword
    case LoopKeyword

    // Operators - Pattern
    case IsOperator
    case AsOperator
    case InOperator

    // Operators - Control Flow
    case ReturnOperator
    case BreakOperator
    case ContinueOperator
    case TryOperator
    case AwaitOperator

    // Operators - Lambda
    case LambdaOperator

    // Operators - Additive
    case PlusOperator
    case MinusOperator

    // Operators - Multiplicative
    case MultiplyOperator
    case DivideOperator
    case ModuloOperator
    case PowerOperator

    // Operators - Assignment
    case AssignOperator
    case PlusAssignOperator
    case MinusAssignOperator
    case MultiplyAssignOperator
    case DivideAssignOperator
    case ModuloAssignOperator
    case PowerAssignOperator
    case BitwiseAndAssignOperator
    case BitwiseOrAssignOperator
    case BitwiseXorAssignOperator
    case BitwiseLeftShiftAssignOperator
    case BitwiseRightShiftAssignOperator

    // Operators - Logical
    case LogicalNotOperator
    case LogicalAndOperator
    case LogicalOrOperator

    // Operators - Bitwise Logical
    case BitwiseNotOperator
    case BitwiseAndOperator
    case BitwiseOrOperator
    case BitwiseXorOperator

    // Operators - Bitwise Shift
    case BitwiseLeftShiftOperator
    case BitwiseRightShiftOperator

    // Operators - Equality
    case EqualOperator
    case NotEqualOperator

    // Operators - Relational
    case LessThanOperator
    case LessThanOrEqualOperator
    case GreaterThanOperator
    case GreaterThanOrEqualOperator

    // Operators - Range
    case InclusiveRangeOperator
    case ExclusiveRangeOperator

    // Operators - Access
    case DotOperator

    // Operators - Nullability
    case NullableOperator
    case NullReduceOperator

    // Identifier
    case Identifier
}
