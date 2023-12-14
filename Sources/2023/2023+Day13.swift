extension Challenges2023 {

    @discardableResult static func runDay13(input: Input) async throws -> ChallengeResult {
        let inputPatterns = input.asString().split(separator: "\n\n")

        let patterns = inputPatterns.map({ $0.split(separator: "\n").map({ $0.map(String.init) }) }).map { Grid($0) }

        let part1 = patterns.reduce(0) { result, pattern in
            var summary = 0
            let columns = pattern.columns.map({ $0.map(\.value) })
            let rows = pattern.rows.map({ $0.map(\.value) })

            for c in 0..<(columns.count-1) {
                let columnsToCheck = min(c + 1, columns.count - c - 1)
                if Array(columns[(c-(columnsToCheck-1))...c].reversed()) == Array(columns[(c+1)...(c+columnsToCheck)]) {
                    summary += (c + 1)
                }
            }

            for r in 0..<(rows.count-1) {
                let rowsToCheck = min(r + 1, rows.count - r - 1)
                if Array(rows[(r-(rowsToCheck-1))...r].reversed()) == Array(rows[(r+1)...(r+rowsToCheck)]) {
                    summary += 100 * (r + 1)
                }
            }

            return result + summary
        }
        print("Part 1: The summary number of all notes is \(part1)")

        return (part1: "\(part1)", part2: "")
    }

}
