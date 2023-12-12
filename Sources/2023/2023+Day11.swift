import RegexBuilder


extension Challenges2023 {

    private typealias Galaxy = Grid<String>.Point

    private static func expand(galaxies: [Galaxy], by amount: Int, emptyRows: [Int], emptyColumns: [Int]) -> [Galaxy] {
        galaxies.map { galaxy in
            let emptyRowsBefore = emptyRows.filter({ $0 < galaxy.y }).count
            let emptyColumnsBefore = emptyColumns.filter({ $0 < galaxy.x }).count
            return Galaxy(x: galaxy.x + emptyColumnsBefore * amount, y: galaxy.y + emptyRowsBefore * amount, value: galaxy.value)
        }
    }

    private static func distances(between galaxies: [Galaxy], expandedBy amount: Int, emptyRows: [Int], emptyColumns: [Int]) -> Int {
        let expandedGalaxies = self.expand(galaxies: galaxies, by: amount, emptyRows: emptyRows, emptyColumns: emptyColumns)
        var totalDistance = 0
        for i1 in 0..<(expandedGalaxies.count - 1) {
            for i2 in i1..<expandedGalaxies.count {
                totalDistance += expandedGalaxies[i1].manhattanDistance(to: expandedGalaxies[i2])
            }
        }
        return totalDistance
    }

    @discardableResult static func runDay11(input: Input) async throws -> ChallengeResult {
        let image = Grid(input.lines().map({ $0.map(String.init) }))
        let galaxies = image.allPoints.filter({ $0.value == "#" })
        let emptyRows = image.rows.enumerated().filter({ $0.element.allSatisfy({ $0.value == "." }) }).map(\.offset)
        let emptyColumns = image.columns.enumerated().filter({ $0.element.allSatisfy({ $0.value == "." }) }).map(\.offset)

        let part1 = self.distances(between: galaxies, expandedBy: 1, emptyRows: emptyRows, emptyColumns: emptyColumns)
        print("Part 1: The sum of the shortest paths between all galaxies expanded by 1 is \(part1)")

        let part2 = self.distances(between: galaxies, expandedBy: 1_000_000 - 1 /* "replaced" by 1M */, emptyRows: emptyRows, emptyColumns: emptyColumns)
        print("Part 1: The sum of the shortest paths between all galaxies expanded by 1000000 is \(part2)")

        return (part1: "\(part1)", part2: "\(part2)")
    }

}
