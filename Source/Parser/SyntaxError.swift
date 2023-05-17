struct SyntaxError : Error, CustomStringConvertible
{
    let location: String?

    let message: String

    var description: String {
        return "\n\n\(location ?? ""): \(message)\n"
    }
}
