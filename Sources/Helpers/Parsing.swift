
extension StringProtocol {

    /// Parses a string of numbers, separated by one or multiple spaces, to an array of `Int`s.
    func numbers(separator: String = " ") -> [Int] {
        String(self).replacing(/\s+/, with: " ").split(separator: separator).map { Int($0)! }
    }

}
