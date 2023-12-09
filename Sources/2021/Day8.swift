import Algorithms


extension Challenges2021 {

    private static let digitPatterns = ["abcefg": 0, "cf": 1, "acdeg": 2, "acdfg": 3, "bcdf": 4, "abdfg": 5, "abdefg": 6, "acf": 7, "abcdefg": 8, "abcdfg": 9]

    private static let mappingPermutations:  [[Character: Character]] = {
        let segments = "abcdefg"
        let permutations = segments.permutations()
        return permutations.map({ Dictionary(uniqueKeysWithValues: zip(segments, $0)) })
    }()

    private static func findMapping(for patterns: [String]) -> [Character: Character] {
        return self.mappingPermutations.first(where: { mapping -> Bool in
            patterns.allSatisfy({ pattern in
                self.digitPatterns.keys.contains(pattern.applying(mapping: mapping))
            })
        })!
    }

    @discardableResult static func runDay8(input: Input) async throws -> ChallengeResult {
        let lines = input.lines()
        let notes = lines.map { line -> (patterns: [String], output: [String]) in
            let parts = line.replacingOccurrences(of: " | ", with: "|").split(separator: "|")
            let uniquePatterns = parts.first!.split(separator: " ").map(String.init)
            let output = parts.last!.split(separator: " ").map(String.init)
            return (patterns: uniquePatterns, output: output)
        }


        // Part 1

        let uniqueSegmentCounts = [2, 3, 4, 7]
        let outputs = notes.map(\.output).flatMap({ $0 })
        let numUniqueSegments = outputs.filter({ uniqueSegmentCounts.contains($0.count) }).count

        print("Part 1: In the output values, the digits 1, 4, 7, or 8 appear \(numUniqueSegments) times.")


        // Part 2

        let outputValues = notes.map { (note: (patterns: [String], output: [String])) -> Int in
            let mapping = self.findMapping(for: note.patterns)
            let digits = note.output.map({ $0.applying(mapping: mapping) }).map({ self.digitPatterns[$0]! })
            let stringValue = digits.map(String.init).joined()
            return Int(stringValue)!
        }
        let valueSum = outputValues.sum

        print("Part 2: All of the output values add up to \(valueSum).")


        return (part1: "\(numUniqueSegments)", part2: "\(valueSum)")
    }

}


private extension String {

    func applying(mapping: [Character: Character]) -> String {
        return String(self.map({ mapping[$0]! }).sorted())
    }

}
