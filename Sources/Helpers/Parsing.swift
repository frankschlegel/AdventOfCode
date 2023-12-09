
extension StringProtocol {

    /// Parses a string of numbers, separated by one or multiple spaces, to an array of `Int`s.
    var numbers: [Int] {
        String(self).replacing(/\s+/, with: " ").split(separator: " ").map { Int($0)! }
    }

}
