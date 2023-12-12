import RegexBuilder


private struct Values {

    let history: [Int]

    init(_ string: String) {
        self.history = string.numbers()
    }

    private var differences: [[Int]] {
        var differences = [self.history]
        while !differences.last!.allSatisfy({ $0 == 0 }) {
            let diffs = differences.last!.adjacentPairs().map({ $0.1 - $0.0 })
            differences.append(diffs)
        }
        return differences
    }

    var next: Int {
        let differences = self.differences
        return differences.map(\.last!).sum
    }

    var previous: Int {
        let differences = self.differences
        return differences.reversed().map(\.first!).reduce(0, { $1 - $0 })
    }

}


extension Challenges2023 {

    @discardableResult static func runDay9(input: Input) async throws -> ChallengeResult {
        let values = input.lines().map(Values.init)

        let part1 = values.map(\.next).sum
        print("Part 1: The sum of next values is \(part1)")

        let part2 = values.map(\.previous).sum
        print("Part 2: The sum of previous values is \(part2)")

        return ("\(part1)", "\(part2)")
    }

}
