extension Challenges2021 {

    fileprivate typealias Cave = Grid<Int>
    fileprivate typealias Node = Cave.Point
    fileprivate typealias Path = [Node]


    /// Based on https://en.wikipedia.org/wiki/A*_search_algorithm#Pseudocode
    private static func a_star(from start: Node, to goal: Node, in cave: Cave) -> Path {
        // The heuristic function. heuristic(n) estimates the cost to reach goal from node n.
        // Using Manhattan distance here.
        let heuristic = { (node: Node) -> Int in
            return abs(goal.x - node.x) + abs(goal.y - node.y)
        }

        // The set of discovered nodes that may need to be (re-)expanded.
        // Initially, only the start node is known.
        var openSet = Set([start])

        // For node n, cameFrom[n] is the node immediately preceding it on the cheapest path from start
        // to n currently known.
        var cameFrom = [Node: Node]()

        // For node n, gScore[n] is the cost of the cheapest path from start to n currently known.
        var gScore = [start: 0]

        // For node n, fScore[n] := gScore[n] + heuristic(n). fScore[n] represents our current best guess as to
        // how short a path from start to finish can be if it goes through n.
        var fScore = [start: heuristic(start)]

        while !openSet.isEmpty {
            let current = openSet.min(by: { fScore[$0, default: .max] < fScore[$1, default: .max] })!
            if current == goal {
                return self.reconstructPath(cameFrom: cameFrom, current: current)
            }

            openSet.remove(current)
            for neighbor in cave.getDirectNeighbors(current) {
                // tentativeGScore is the distance from start to the neighbor through current
                let tentativeGScore = gScore[current]! + neighbor.value
                if tentativeGScore < gScore[neighbor, default: .max] {
                    // This path to neighbor is better than any previous one. Record it!
                    cameFrom[neighbor] = current
                    gScore[neighbor] = tentativeGScore
                    fScore[neighbor] = tentativeGScore + heuristic(neighbor)
                    openSet.insert(neighbor)
                }
            }
        }

        // Open set is empty but goal was never reached.
        return []
    }

    private static func reconstructPath(cameFrom: [Node: Node], current: Node) -> Path {
        var path = [current]
        var current = current
        while cameFrom.keys.contains(current) {
            current = cameFrom[current]!
            path.append(current)
        }
        return path.reversed()
    }


    @discardableResult static func runDay15(input: Input) async throws -> ChallengeResult {
        let cave = Cave(input.lines().map({ $0.map({ Int(String($0))! }) }))


        // Part 1

        let start1: Node = cave[0, 0]!
        let goal1: Node = cave[cave.width-1, cave.height-1]!
        let path1 = self.a_star(from: start1, to: goal1, in: cave)
        let totalRisk1 = path1.map(\.value).sum - start1.value

        print("Part 1: The lowest total risk of any path from the top left to the bottom right is \(totalRisk1).")


        // Part 2

        let extendedCave = cave.extended(times: 4)
        let start2: Node = extendedCave[0, 0]!
        let goal2: Node = extendedCave[extendedCave.width-1, extendedCave.height-1]!
        let path2 = self.a_star(from: start2, to: goal2, in: extendedCave)
        let totalRisk2 = path2.map(\.value).sum - start2.value

        print("Part 2: Using the full map, the lowest total risk of any path from the top left to the bottom right is \(totalRisk2).")


        return (part1: "\(totalRisk1)", part2: "\(totalRisk2)")
    }

}


private extension Challenges2021.Cave {

    func extended(times: Int) -> Self {
        let extendedRows = self.elements.map { (row: [Int]) -> [Int] in
            var newRow = row
            for i in 1...times {
                newRow.append(contentsOf: row.map({ ($0 + i) > 9 ? ($0 + i - 9) : ($0 + i) }))
            }
            return newRow
        }

        var newElements = extendedRows
        for i in 1...times {
            let newRows = extendedRows.map { row in
                row.map({ ($0 + i) > 9 ? ($0 + i - 9) : ($0 + i)  })
            }
            newElements.append(contentsOf: newRows)
        }

        return Self(newElements)
    }

}
