extension Parser
{
    func TypeParameters() throws -> [Expression]
    {
        var typeParameters: [Expression] = []

        while let lookAhead = lookAhead, lookAhead.Kind == .Identifier {
            typeParameters.append(try TypeParameter())
        }

        return typeParameters
    }
}
