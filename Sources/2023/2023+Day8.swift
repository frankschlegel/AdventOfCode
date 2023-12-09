import RegexBuilder


private struct Node: Identifiable, Hashable {
    typealias ID = String

    let id: Node.ID
    let leftID: Node.ID
    let rightID: Node.ID

    static func == (lhs: Node, rhs: Node) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }

    init(_ string: String) {
        let regex = /([\w\d]{3}) = \(([\w\d]{3}), ([\w\d]{3})\)/
        let match = string.wholeMatch(of: regex)!.output
        self.id = String(match.1)
        self.leftID = String(match.2)
        self.rightID = String(match.3)
    }

    func next(in direction: Direction, network: [Node.ID: Node]) -> Node {
        switch direction {
            case .left: network[self.leftID]!
            case .right: network[self.rightID]!
        }
    }
}

private enum Direction {
    case left, right

    init(_ char: Character) {
        switch char {
            case "L": self = .left
            case "R": self = .right
            default: fatalError()
        }
    }
}

extension Challenges2023 {

    @discardableResult static func runDay8(input: Input) async throws -> ChallengeResult {
        var lines = input.lines()

        let directions = lines.removeFirst().map(Direction.init)
        let network = Dictionary(uniqueKeysWithValues: lines.map(Node.init).map({ ($0.id, $0) }))


        // Part 1

        var stepsPart1 = 0
        if var nodePart1 = network["AAA"] {
            while nodePart1.id != "ZZZ" {
                let direction = directions[stepsPart1 % directions.count]
                stepsPart1 += 1
                nodePart1 = nodePart1.next(in: direction, network: network)
            }
        }
        print("Part 1: It took \(stepsPart1) steps to node ZZZ")


        // Part 2

        // For each node in the network, determine the path from it if it were the starting point
        // at the beginning of `directions`. We'll use this map to speed up the lookup later.
        var pathsPerNode = [Node: [Node]]()
        for node in network.values {
            var current = node
            var path = [Node]()
            for direction in directions {
                current = current.next(in: direction, network: network)
                path.append(current)
            }
            pathsPerNode[node] = path
        }

        // Filter out those nodes who's paths actually contain nodes that end in 'Z'.
        let endsWithZ = pathsPerNode.mapValues { $0.map({ $0.id.last == "Z" }) }.filter({ !$0.value.allSatisfy({ !$0 }) })
        
        // Start with all nodes that end with 'A'.
        var nodesPart2 = Array(network.filter({ $0.key.last == "A" }).values)
        var stepsPart2 = 1
        while true {
            // Check how many of the nodes map to paths that contain at least one 'Z' node...
            let validPaths = nodesPart2.compactMap({ endsWithZ[$0] })
            if validPaths.count == nodesPart2.count { 
                // ... and if all of them have a 'Z' path, check if the 'Z' is at the same position...
                if let allZIndex = validPaths.first!.indices.first(where: { index in validPaths.allSatisfy({ path in path[index] }) }) {
                    stepsPart2 += allZIndex
                    break
                }
            }

            // ... otherwise go to the end of the paths and check again from there.
            nodesPart2 = nodesPart2.map({ pathsPerNode[$0]!.last! })
            stepsPart2 += directions.count
        }
        print("Part 2: It took \(stepsPart2) steps to reach nodes ending with 'Z'")


        return ("\(stepsPart1)", "\(stepsPart2)")
    }

}
