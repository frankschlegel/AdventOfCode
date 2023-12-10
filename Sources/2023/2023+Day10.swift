import RegexBuilder


private extension Grid<String> {
    
    func nextPoint(from point: Point, comingFrom previousPoint: Point) -> Point? {
        switch point.value {
            case ".": nil
            case "-": (point.x == (previousPoint.x + 1)) ? self[point.x + 1, point.y] : ((point.x == (previousPoint.x - 1)) ? self[point.x - 1, point.y] : nil)
            case "|": (point.y == (previousPoint.y + 1)) ? self[point.x, point.y + 1] : ((point.y == (previousPoint.y - 1)) ? self[point.x, point.y - 1] : nil)
            case "F": (point.x == (previousPoint.x - 1)) ? self[point.x, point.y + 1] : ((point.y == (previousPoint.y - 1)) ? self[point.x + 1, point.y] : nil)
            case "7": (point.x == (previousPoint.x + 1)) ? self[point.x, point.y + 1] : ((point.y == (previousPoint.y - 1)) ? self[point.x - 1, point.y] : nil)
            case "L": (point.x == (previousPoint.x - 1)) ? self[point.x, point.y - 1] : ((point.y == (previousPoint.y + 1)) ? self[point.x + 1, point.y] : nil)
            case "J": (point.x == (previousPoint.x + 1)) ? self[point.x, point.y - 1] : ((point.y == (previousPoint.y + 1)) ? self[point.x - 1, point.y] : nil)
            default: nil
        }
    }

}

private extension Grid<String>.Point {

    enum Location { case top, bottom, left, right }

    func location(inRelationTo other: Self) -> Location {
        if self.x < other.x { .left }
        else if self.x > other.x { .right }
        else if self.y < other.y { .top }
        else if self.y > other.y { .bottom }
        else { fatalError() }
    }

}


extension Challenges2023 {

    @discardableResult static func runDay10(input: Input) async throws -> ChallengeResult {
        var grid = Grid(input.lines().map({ $0.map(String.init) }))
        let start = grid.allPoints.first(where: { $0.value == "S" })!

        // Part 1: Determine path

        var path = [start]
        var next = grid.getDirectNeighbors(start).filter({ grid.nextPoint(from: $0, comingFrom: start) != nil }).first!
        while next != start {
            let previous = path.last!
            path.append(next)
            next = grid.nextPoint(from: next, comingFrom: previous)!
        }

        let part1 = path.count / 2
        print("Part 1: The number of steps to the farthest point is \(part1)")

        // Part 2: Scan-line fill path

        // Replace 'S' with correct symbol
        let after = path[1]
        let before = path.last!
        let startSymbol = switch (before.location(inRelationTo: start), after.location(inRelationTo: start)) {
            case (.left, .right), (.right, .left): "-"
            case (.top, .bottom), (.bottom, .top): "|"
            case (.left, .top), (.top, .left): "J"
            case (.left, .bottom), (.bottom, .left): "7"
            case (.right, .top), (.top, .right): "L"
            case (.right, .bottom), (.bottom, .right): "F"
            default: fatalError()
        }
        grid[start.x, start.y] = startSymbol
        path[0] = Grid<String>.Point(x: start.x, y: start.y, value: startSymbol)

        // Scan grid line by line.
        for (y, scanLine) in grid.rows.enumerated() {
            var next = 0
            var pathLine = [Int]()
            // Build an edge map.
            for point in scanLine {
                if !path.contains(point) {
                    pathLine.append(0)
                } else {
                    switch point.value {
                        case "F", "L": next += 1
                        case "-": next += 0
                        case "7", "J": next += 0
                        case "|": next += 2;
                        default: fatalError()
                    }
                    pathLine.append(next)
                }
            }
            print(pathLine.map(String.init).joined())

            // Check for changes in the edge map and fill free spots between odd and even edges/
            var previous = 0
            for (x, edge) in pathLine.enumerated() {
                if edge == 0, x != (pathLine.count - 1), previous != 0, previous.isMultiple(of: 2), pathLine[((x+1)...)].contains(where: { $0 > previous }) {
                    grid[x, y] = "I"
                } else {
                    previous = edge
                }
            }
        }
        print(grid)

        let part2 = grid.allPoints.filter({ $0.value == "I" }).count
        print("Part 2: There are \(part2) tiles enclosed in the loop")

        return ("\(part1)", "\(part2)")
    }

}
