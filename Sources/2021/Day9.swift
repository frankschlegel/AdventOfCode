private typealias HeightMap = Grid<Int>

extension HeightMap {

    var lowPoints: [Point] {
        return self.allPoints.filter({ point in self.getDirectNeighbors(point).allSatisfy({ $0.value > point.value }) })
    }

    func basin(of lowPoint: Point) -> Set<Point> {
        var basinPoints: Set<Point> = []
        var newPoints: Set<Point> = [lowPoint]
        while !newPoints.isEmpty {
            basinPoints = basinPoints.union(newPoints)
            newPoints = newPoints.reduce(Set<Point>(), { partialResult, point in
                let adjacent = self.getDirectNeighbors(point)
                let increasing = adjacent.filter({ $0.value < 9 && $0.value > point.value })
                let unseen = increasing.subtracting(basinPoints)
                return partialResult.union(unseen)
            })
        }

        return basinPoints
    }

}


extension Challenges2021 {

    @discardableResult static func runDay9(input: Input) async throws -> ChallengeResult {
        let heightMap = HeightMap(input.lines().map({ $0.map({ Int(String($0))! }) }))


        // Part 1

        let lowPoints = heightMap.lowPoints
        let riskLevels = lowPoints.map({ $0.value + 1 })
        let riskSum = riskLevels.sum

        print("Part 1: The sum of the risk levels of all low points on the heightmap is \(riskSum).")


        // Part 2

        let basins = lowPoints.map({ heightMap.basin(of: $0) })
        let largestBasins = basins.max(count: 3, sortedBy: { $0.count < $1.count })
        let sizeProduct = largestBasins.reduce(1, { $0 * $1.count })

        print("Part 2: The product of the sizes of the three largest basins is \(sizeProduct)")

        return (part1: "\(riskSum)", part2: "\(sizeProduct)")
    }

}
