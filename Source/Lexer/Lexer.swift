import RegexBuilder

struct Lexer
{
    let source: String

    var Cursor: Int = 0

    var Line: Int = 1

    var Column: Int = 1

    var Prop: Int {
        get {
            let prop = Cursor
            return prop
        }

        mutating set {
            precondition(newValue >= Cursor)
        }
    }

    var RestOfSource: String.SubSequence {
        source[source.index(source.startIndex, offsetBy: Cursor)...]
    }

    init(source: String) {
        self.source = source
    }

    func HasMoreTokens() -> Bool {
        Cursor < source.count
    }

    mutating func NextToken() -> Token?
    {
        guard HasMoreTokens() else {
            return Tokenize(kind: .EndOfFile)
        }

        switch RestOfSource[RestOfSource.startIndex]
        {
            case let newLine where newLine.isNewline:
                return Tokenize(kind: .EndOfLine)

            case let whitespace where whitespace.isWhitespace:
                return Tokenize(kind: .Whitespace)

            case "/":
                return Tokenize(kind: .DivideAssignOperator)
                    ?? Tokenize(kind: .DocumentationComment)
                    ?? Tokenize(kind: .MultiLineComment)
                    ?? Tokenize(kind: .SingleLineComment)
                    ?? Tokenize(kind: .DivideOperator)

            case ";":
                return Tokenize(kind: .Semicolon)

            case ":":
                return Tokenize(kind: .Colon)

            case ",":
                return Tokenize(kind: .Comma)

            case "(":
                return Tokenize(kind: .OpenParenthesis)

            case ")":
                return Tokenize(kind: .CloseParenthesis)

            case "{":
                return Tokenize(kind: .OpenBrace)

            case "}":
                return Tokenize(kind: .CloseBrace)

            case "[":
                return Tokenize(kind: .OpenBracket)

            case "]":
                return Tokenize(kind: .CloseBracket)

            case "@":
                return Tokenize(kind: .AtSign)

            case "_":
                return Tokenize(kind: .Underscore)
                    ?? Tokenize(kind: .Identifier)

            case "n":
                return Tokenize(kind: .NullLiteral)
                    ?? Tokenize(kind: .Identifier)

            case "t", "f":
                return Tokenize(kind: .TypeKeyword)
                    ?? Tokenize(kind: .BooleanLiteral)
                    ?? Tokenize(kind: .Identifier)

            case let digit where digit.isNumber:
                return Tokenize(kind: .NumericLiteral)

            case "'":
                return Tokenize(kind: .CharacterLiteral)

            case "\"":
                return Tokenize(kind: .TextLiteral)

            case "e":
                return Tokenize(kind: .ElseKeyword)
                    ?? Tokenize(kind: .ExtendKeyword)
                    ?? Tokenize(kind: .EnumKeyword)
                    ?? Tokenize(kind: .EdgeKeyword)
                    ?? Tokenize(kind: .Identifier)

            case "v":
                return Tokenize(kind: .VarKeyword)
                    ?? Tokenize(kind: .Identifier)

            case "c":
                return Tokenize(kind: .ConstKeyword)
                    ?? Tokenize(kind: .ContinueOperator)
                    ?? Tokenize(kind: .Identifier)

            case "p":
                return Tokenize(kind: .ProcKeyword)
                    ?? Tokenize(kind: .Identifier)

            case "i":
                return Tokenize(kind: .IfKeyword)
                    ?? Tokenize(kind: .InOperator)
                    ?? Tokenize(kind: .InterfaceKeyword)
                    ?? Tokenize(kind: .IsOperator)
                    ?? Tokenize(kind: .Identifier)

            case "u":
                return Tokenize(kind: .UnionKeyword)
                    ?? Tokenize(kind: .Identifier)

            case "m":
                return Tokenize(kind: .MatchKeyword)
                    ?? Tokenize(kind: .ModuleKeyword)
                    ?? Tokenize(kind: .Identifier)

            case "w":
                return Tokenize(kind: .WhileKeyword)
                    ?? Tokenize(kind: .Identifier)

            case "l":
                return Tokenize(kind: .LoopKeyword)
                    ?? Tokenize(kind: .Identifier)

            case "a":
                return Tokenize(kind: .AsOperator)
                    ?? Tokenize(kind: .Identifier)

            case "r":
                return Tokenize(kind: .ReturnOperator)
                    ?? Tokenize(kind: .RawTextLiteral)
                    ?? Tokenize(kind: .Identifier)

            case "b":
                return Tokenize(kind: .BreakOperator)
                    ?? Tokenize(kind: .Identifier)

            case "+":
                return Tokenize(kind: .PlusAssignOperator)
                    ?? Tokenize(kind: .PlusOperator)

            case "-":
                return Tokenize(kind: .MinusAssignOperator)
                    ?? Tokenize(kind: .MinusOperator)

            case "*":
                return Tokenize(kind: .MultiplyAssignOperator)
                    ?? Tokenize(kind: .PowerAssignOperator)
                    ?? Tokenize(kind: .PowerOperator)
                    ?? Tokenize(kind: .MultiplyOperator)

            case "%":
                return Tokenize(kind: .ModuloAssignOperator)
                    ?? Tokenize(kind: .ModuloOperator)

            case "=":
                return Tokenize(kind: .EqualOperator)
                    ?? Tokenize(kind: .AssignOperator)
                    ?? Tokenize(kind: .LambdaOperator)

            case "!":
                return Tokenize(kind: .NotEqualOperator)
                    ?? Tokenize(kind: .LogicalNotOperator)

            case "<":
                return Tokenize(kind: .LessThanOrEqualOperator)
                    ?? Tokenize(kind: .BitwiseLeftShiftAssignOperator)
                    ?? Tokenize(kind: .LessThanOperator)

            case ">":
                return Tokenize(kind: .GreaterThanOrEqualOperator)
                    ?? Tokenize(kind: .BitwiseRightShiftAssignOperator)
                    ?? Tokenize(kind: .GreaterThanOperator)

            case "&":
                    return Tokenize(kind: .LogicalAndOperator)
                    ?? Tokenize(kind: .BitwiseAndAssignOperator)
                    ?? Tokenize(kind: .BitwiseAndOperator)

            case "|":
                return Tokenize(kind: .LogicalOrOperator)
                    ?? Tokenize(kind: .BitwiseOrAssignOperator)
                    ?? Tokenize(kind: .BitwiseOrOperator)

            case "^":
                return Tokenize(kind: .BitwiseXorAssignOperator)
                    ?? Tokenize(kind: .BitwiseXorOperator)

            case "~":
                return Tokenize(kind: .BitwiseNotOperator)

            case ".":
                return Tokenize(kind: .ExclusiveRangeOperator)
                    ?? Tokenize(kind: .InclusiveRangeOperator)
                    ?? Tokenize(kind: .DotOperator)

            case "?":
                return Tokenize(kind: .NullReduceOperator)
                    ?? Tokenize(kind: .NullableOperator)

            default:
                return Tokenize(kind: .Identifier)
        }
    }

    mutating func Tokenize(kind: TokenKind) -> Token? {
        guard kind != .EndOfFile else {
            return Token(
                Kind: kind,
                Value: TokenKind.EndOfFile.rawValue,
                Location: String(Line)
            )
        }

        guard let match = kind.Match(input: String(RestOfSource))?.output else {
            return nil
        }

        Cursor += match.count

        var currentLine = Line
        var currentColumn = Column

        switch kind
        {
            case .Whitespace:
                Column += match.count
                return NextToken()

            case .EndOfLine:
                Line += 1
                Column = 1
                return NextToken()

            case .SingleLineComment, .MultiLineComment:
                Line += match.filter { $0.isNewline }.count
                return NextToken()

            default:
                Column += match.count
        }

        return Token(
            Kind: kind,
            Value: String(match),
            Location: "\(currentLine):\(Column - currentColumn > 1 ? "\(currentColumn)-\(Column - 1)" : "\(currentColumn)")"
        )
    }
}

