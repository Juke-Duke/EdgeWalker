import RegexBuilder

extension TokenKind
{
    static let patterns: [TokenKind : Regex<Substring>] = [
        .Whitespace                         : Regex {
                                                OneOrMore(.whitespace)
                                            },

        .EndOfLine                          : Regex {
                                                Anchor.startOfLine ;
                                                .newlineSequence
                                            },

        .SingleLineComment                  : Regex {
                                                "//"
                                                ZeroOrMore(.anyNonNewline)
                                            },

        .MultiLineComment                   : Regex {
                                                "/*"
                                                ZeroOrMore(.any, .eager)
                                                "*/"
                                            },

        .DocumentationComment               : Regex {
                                                OneOrMore {
                                                    "///"
                                                    ZeroOrMore(.anyNonNewline)
                                                }
                                            },

        .Semicolon                          : Regex { ";" },

        .Colon                              : Regex { ":" },

        .Comma                              : Regex { "," },

        .OpenParenthesis                    : Regex { "(" },

        .CloseParenthesis                   : Regex { ")" },

        .OpenBrace                          : Regex { "{" },

        .CloseBrace                         : Regex { "}" },

        .OpenBracket                        : Regex { "[" },

        .CloseBracket                       : Regex { "]" },

        .AtSign                             : Regex { "@" },

        .Underscore                         : Regex {
                                                Anchor.wordBoundary
                                                "_"
                                                Anchor.wordBoundary
                                            },

        .NullLiteral                        : Regex {
                                                Anchor.wordBoundary
                                                "null"
                                                Anchor.wordBoundary
                                            },

        .BooleanLiteral                     : Regex {
                                                Anchor.wordBoundary
                                                ChoiceOf { "true" ; "false" }
                                                Anchor.wordBoundary
                                            },

        .NumericLiteral                     : Regex {
                                                OneOrMore(.digit)
                                            },

        .CharacterLiteral                   : Regex {
                                                "'" ;
                                                .any
                                                "'"
                                            },

        .TextLiteral                        : Regex {
                                                "\""
                                                ZeroOrMore(.any, .reluctant)
                                                "\""
                                            },

        .RawTextLiteral                     : Regex {
                                                "r\""
                                                ZeroOrMore(.any, .reluctant)
                                                "\""
                                            },

        .EdgeKeyword                        : Regex {
                                                Anchor.wordBoundary
                                                "edge"
                                                Anchor.wordBoundary
                                            },

        .VarKeyword                    : Regex {
                                                Anchor.wordBoundary
                                                "var"
                                                Anchor.wordBoundary
                                            },

        .ConstKeyword                    : Regex {
                                                Anchor.wordBoundary
                                                "const"
                                                Anchor.wordBoundary
                                            },

        .ProcedureKeyword                   : Regex {
                                                Anchor.wordBoundary
                                                "proc"
                                                Anchor.wordBoundary
                                            },

        .TypeKeyword                        : Regex {
                                                Anchor.wordBoundary
                                                "type"
                                                Anchor.wordBoundary
                                            },

        .ExtendKeyword                      : Regex {
                                                Anchor.wordBoundary
                                                "extend"
                                                Anchor.wordBoundary
                                            },

        .InterfaceKeyword                   : Regex {
                                                Anchor.wordBoundary
                                                "interface"
                                                Anchor.wordBoundary
                                            },

        .UnionKeyword                       : Regex {
                                                Anchor.wordBoundary
                                                "union"
                                                Anchor.wordBoundary
                                            },

        .EnumKeyword                        : Regex {
                                                Anchor.wordBoundary
                                                "enum"
                                                Anchor.wordBoundary
                                            },

        .IfKeyword                          : Regex {
                                                Anchor.wordBoundary
                                                "if"
                                                Anchor.wordBoundary
                                            },

        .ElseKeyword                        : Regex {
                                                Anchor.wordBoundary
                                                "else"
                                                Anchor.wordBoundary
                                            },

        .MatchKeyword                       : Regex {
                                                Anchor.wordBoundary
                                                "match"
                                                Anchor.wordBoundary
                                            },

        .ForKeyword                         : Regex {
                                                Anchor.wordBoundary
                                                "for"
                                                Anchor.wordBoundary
                                            },

        .WhileKeyword                       : Regex {
                                                Anchor.wordBoundary
                                                "while"
                                                Anchor.wordBoundary
                                            },

        .LoopKeyword                        : Regex {
                                                Anchor.wordBoundary
                                                "loop"
                                                Anchor.wordBoundary
                                            },

        .IsOperator                         : Regex {
                                                Anchor.wordBoundary
                                                "is"
                                                Anchor.wordBoundary
                                            },

        .AsOperator                         : Regex {
                                                Anchor.wordBoundary
                                                "as"
                                                Anchor.wordBoundary
                                            },

        .InOperator                         : Regex {
                                                Anchor.wordBoundary
                                                "in"
                                                Anchor.wordBoundary
                                            },

        .ReturnOperator                     : Regex {
                                                Anchor.wordBoundary
                                                "return"
                                                Anchor.wordBoundary
                                            },

        .BreakOperator                      : Regex {
                                                Anchor.wordBoundary
                                                "break"
                                                Anchor.wordBoundary
                                            },

        .ContinueOperator                   : Regex {
                                                Anchor.wordBoundary
                                                "continue"
                                                Anchor.wordBoundary
                                            },

        .PlusOperator                       : Regex { "+" },

        .MinusOperator                      : Regex { "-" },

        .MultiplyOperator                   : Regex { "*" },

        .DivideOperator                     : Regex { "/" },

        .ModuloOperator                     : Regex { "%" },

        .PowerOperator                      : Regex { "**" },

        .AssignOperator                     : Regex { "=" },

        .PlusAssignOperator                 : Regex { "+=" },

        .MinusAssignOperator                : Regex { "-=" },

        .MultiplyAssignOperator             : Regex { "*=" },

        .DivideAssignOperator               : Regex { "/=" },

        .ModuloAssignOperator               : Regex { "%=" },

        .PowerAssignOperator                : Regex { "**=" },

        .BitwiseAndAssignOperator           : Regex { "&=" },

        .BitwiseOrAssignOperator            : Regex { "|=" },

        .BitwiseXorAssignOperator           : Regex { "^=" },

        .BitwiseLeftShiftAssignOperator     : Regex { "<<=" },

        .BitwiseRightShiftAssignOperator    : Regex { ">>=" },

        .LogicalNotOperator                 : Regex { "!" },

        .LogicalAndOperator                 : Regex { "&&" },

        .LogicalOrOperator                  : Regex { "||" },

        .BitwiseNotOperator                 : Regex { "~" },

        .BitwiseAndOperator                 : Regex { "&" },

        .BitwiseOrOperator                  : Regex { "|" },

        .BitwiseXorOperator                 : Regex { "^" },

        .BitwiseLeftShiftOperator           : Regex { "<<" },

        .BitwiseRightShiftOperator          : Regex { ">>" },

        .EqualOperator                      : Regex { "==" },

        .NotEqualOperator                   : Regex { "!=" },

        .LessThanOperator                   : Regex { "<" },

        .LessThanOrEqualOperator            : Regex { "<=" },

        .GreaterThanOperator                : Regex { ">" },

        .GreaterThanOrEqualOperator         : Regex { ">=" },

        .InclusiveRangeOperator             : Regex { ".." },

        .ExclusiveRangeOperator             : Regex { "..<" },

        .DotOperator                        : Regex { "." },

        .NullableOperator                   : Regex { "?" },

        .NullReduceOperator                 : Regex { "??" },

        .Identifier                         : Regex {
                                                Anchor.wordBoundary
                                                One(.word)
                                                ZeroOrMore {
                                                    ChoiceOf {
                                                        "_" ;
                                                        .word ;
                                                        .digit
                                                    }
                                                }
                                                Anchor.wordBoundary
                                            },
    ]

    func Match(input: String) -> Regex<Substring>.Match? {
        try! TokenKind.patterns[self]?.prefixMatch(in: input)
    }
}
