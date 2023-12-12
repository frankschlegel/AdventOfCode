import CollectionConcurrencyKit
import RegexBuilder


private typealias Springs = String

private struct Line {

    let springs: Springs
    let records: [Int]

    init(springs: Springs, records: [Int]) {
        self.springs = springs
        self.records = records
    }

    init(string: String) throws {
        let regex = /([\.#?]+)\s([\d,]+)/
        let match = try regex.wholeMatch(in: string)!.output
        self.init(springs: Springs(match.1), records: match.2.numbers(separator: ","))
    }

    var unfolded: Line {
        let newSprings = (1...5).map({ _ in self.springs }).joined(by: "?")
        let newRecords = (1...5).flatMap({ _ in self.records })
        return Line(springs: String(newSprings), records: newRecords)
    }

    var numValidCombinations: Int {
        self.numValidCombinations(springs: self.springs)
    }

    private func numValidCombinations(springs: String) -> Int {
        if let index = springs.firstIndex(of: "?") {
            return numValidCombinations(springs: springs.replacingCharacters(in: index...index, with: ".")) +
                   numValidCombinations(springs: springs.replacingCharacters(in: index...index, with: "#"))
        } else {
            return springs.isValid(for: self.records) ? 1 : 0
        }
    }

}

private extension Springs {

    func isValid(for records: [Int]) -> Bool {
        self.replacing(/\.+/, with: ".").split(separator: ".").map(\.count) == records
    }

}


extension Challenges2023 {

    @discardableResult static func runDay12(input: Input) async throws -> ChallengeResult {
        let lines = try input.lines().map(Line.init)

        let part1 = await lines.concurrentMap(\.numValidCombinations).sum
        print("Part 1: The sum of possible arrangements is \(part1)")

        let part2 = await lines.map(\.unfolded).concurrentMap(\.numValidCombinations).sum
        print("Part 2: The sum of possible arrangements is \(part2)")

        return (part1: "\(part1)", part2: "\(part2)")
    }

}
