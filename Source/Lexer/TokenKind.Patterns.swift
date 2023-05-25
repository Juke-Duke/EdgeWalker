import RegexBuilder

extension TokenKind
{
    func Match(input: String) -> Regex<Substring>.Match? {
        try! Pattern()?.prefixMatch(in: input)
    }

    func Pattern() -> Regex<Substring>? {
        switch self {
            case .Whitespace: return Regex {
                OneOrMore(.whitespace)
            }

            case .EndOfLine: return Regex {
                Anchor.startOfLine ;
                .newlineSequence
            }

            case .SingleLineComment: return Regex {
                "//"
                ZeroOrMore(.anyNonNewline)
            }

            case .MultiLineComment: return Regex {
                "/*"
                ZeroOrMore(.any)
                "*/"
            }

            case .DocumentationComment: return Regex {
                OneOrMore {
                    "///"
                    ZeroOrMore(.anyNonNewline)
                }
            }

            case .Semicolon: return Regex { ";" }

            case .Colon: return Regex { ":" }

            case .Comma: return Regex { "," }

            case .OpenParenthesis: return Regex { "(" }

            case .CloseParenthesis: return Regex { ")" }

            case .OpenBrace: return Regex { "{" }

            case .CloseBrace: return Regex { "}" }

            case .OpenBracket: return Regex { "[" }

            case .CloseBracket: return Regex { "]" }

            case .AtSign: return Regex { "@" }

            case .Underscore: return Regex {
                Anchor.wordBoundary
                "_"
                Anchor.wordBoundary
            }

            case .NullLiteral: return Regex {
                Anchor.wordBoundary
                "null"
                Anchor.wordBoundary
            }

            case .BooleanLiteral: return Regex {
                Anchor.wordBoundary
                ChoiceOf { "true" ; "false" }
                Anchor.wordBoundary
            }

            case .NumericLiteral: return Regex {
                OneOrMore(.digit)
            }

            case .CharacterLiteral: return Regex {
                "'" ;
                .any
                "'"
            }

            case .TextLiteral: return Regex {
                "\""
                ZeroOrMore(.any, .reluctant)
                "\""
            }

            case .RawTextLiteral: return Regex {
                "r\""
                ZeroOrMore(.any, .reluctant)
                "\""
            }

            case .EdgeKeyword: return Regex {
                Anchor.wordBoundary
                "edge"
                Anchor.wordBoundary
            }

            case .VarKeyword: return Regex {
                Anchor.wordBoundary
                "var"
                Anchor.wordBoundary
            }

            case .ConstKeyword: return Regex {
                Anchor.wordBoundary
                "const"
                Anchor.wordBoundary
            }

            case .ProcKeyword: return Regex {
                Anchor.wordBoundary
                "proc"
                Anchor.wordBoundary
            }

            case .TypeKeyword: return Regex {
                Anchor.wordBoundary
                "type"
                Anchor.wordBoundary
            }

            case .ExtendKeyword: return Regex {
                Anchor.wordBoundary
                "extend"
                Anchor.wordBoundary
            }

            case .InterfaceKeyword: return Regex {
                Anchor.wordBoundary
                "interface"
                Anchor.wordBoundary
            }

            case .UnionKeyword: return Regex {
                Anchor.wordBoundary
                "union"
                Anchor.wordBoundary
            }

            case .EnumKeyword: return Regex {
                Anchor.wordBoundary
                "enum"
                Anchor.wordBoundary
            }

            case .ModuleKeyword: return Regex {
                Anchor.wordBoundary
                "module"
                Anchor.wordBoundary
            }

            case .IfKeyword: return Regex {
                Anchor.wordBoundary
                "if"
                Anchor.wordBoundary
            }

            case .ElseKeyword: return Regex {
                Anchor.wordBoundary
                "else"
                Anchor.wordBoundary
            }

            case .MatchKeyword: return Regex {
                Anchor.wordBoundary
                "match"
                Anchor.wordBoundary
            }

            case .ForKeyword: return Regex {
                Anchor.wordBoundary
                "for"
                Anchor.wordBoundary
            }

            case .WhileKeyword: return Regex {
                Anchor.wordBoundary
                "while"
                Anchor.wordBoundary
            }

            case .LoopKeyword: return Regex {
                Anchor.wordBoundary
                "loop"
                Anchor.wordBoundary
            }

            case .AsyncKeyword: return Regex {
                Anchor.wordBoundary
                "async"
                Anchor.wordBoundary
            }

            case .IsOperator: return Regex {
                Anchor.wordBoundary
                "is"
                Anchor.wordBoundary
            }

            case .AsOperator: return Regex {
                Anchor.wordBoundary
                "as"
                Anchor.wordBoundary
            }

            case .InOperator: return Regex {
                Anchor.wordBoundary
                "in"
                Anchor.wordBoundary
            }

            case .ReturnOperator: return Regex {
                Anchor.wordBoundary
                "return"
                Anchor.wordBoundary
            }

            case .BreakOperator: return Regex {
                Anchor.wordBoundary
                "break"
                Anchor.wordBoundary
            }

            case .ContinueOperator: return Regex {
                Anchor.wordBoundary
                "continue"
                Anchor.wordBoundary
            }

            case .TryOperator: return Regex {
                Anchor.wordBoundary
                "try"
                Anchor.wordBoundary
            }

            case .AwaitOperator: return Regex {
                Anchor.wordBoundary
                "await"
                Anchor.wordBoundary
            }

            case .LambdaOperator: return Regex {
                Anchor.wordBoundary
                "=>"
                Anchor.wordBoundary
            }

            case .PlusOperator: return Regex { "+" }

            case .MinusOperator: return Regex { "-" }

            case .MultiplyOperator: return Regex { "*" }

            case .DivideOperator: return Regex { "/" }

            case .ModuloOperator: return Regex { "%" }

            case .PowerOperator: return Regex { "**" }

            case .AssignOperator: return Regex { "=" }

            case .PlusAssignOperator: return Regex { "+=" }

            case .MinusAssignOperator: return Regex { "-=" }

            case .MultiplyAssignOperator: return Regex { "*=" }

            case .DivideAssignOperator: return Regex { "/=" }

            case .ModuloAssignOperator: return Regex { "%=" }

            case .PowerAssignOperator: return Regex { "**=" }

            case .BitwiseAndAssignOperator: return Regex { "&=" }

            case .BitwiseOrAssignOperator: return Regex { "|=" }

            case .BitwiseXorAssignOperator: return Regex { "^=" }

            case .BitwiseLeftShiftAssignOperator: return Regex { "<<=" }

            case .BitwiseRightShiftAssignOperator: return Regex { ">>=" }

            case .LogicalNotOperator: return Regex { "!" }

            case .LogicalAndOperator: return Regex { "&&" }

            case .LogicalOrOperator: return Regex { "||" }

            case .BitwiseNotOperator: return Regex { "~" }

            case .BitwiseAndOperator: return Regex { "&" }

            case .BitwiseOrOperator: return Regex { "|" }

            case .BitwiseXorOperator: return Regex { "^" }

            case .BitwiseLeftShiftOperator: return Regex { "<<" }

            case .BitwiseRightShiftOperator: return Regex { ">>" }

            case .EqualOperator: return Regex { "==" }

            case .NotEqualOperator: return Regex { "!=" }

            case .LessThanOperator: return Regex { "<" }

            case .LessThanOrEqualOperator: return Regex { "<=" }

            case .GreaterThanOperator: return Regex { ">" }

            case .GreaterThanOrEqualOperator: return Regex { ">=" }

            case .DotOperator: return Regex { "." }

            case .NullableOperator: return Regex { "?" }

            case .NullReduceOperator: return Regex { "??" }

            case .ExclusiveRangeOperator: return Regex { ".." }

            case .InclusiveRangeOperator: return Regex { "..=" }

            case .Identifier: return Regex {
                Anchor.wordBoundary
                One(.word)
                ZeroOrMore {
                    ChoiceOf {
                        "_"     ;
                        .word   ;
                        .digit  ;
                    }
                }
                Anchor.wordBoundary
            }

            case .EndOfFile: return nil
        }
    }
}
