extension Challenges2021 {

    @discardableResult static func runDay7(input: Input) async throws -> ChallengeResult {
        let crabs = input.lines().first!.split(separator: ",").map({ Int(String($0))! })


        // Part 1

        // map each potential position to the total fuel cost for that position (sum of all craps fuel costs)
        let minCost1 = crabs.indices.map({ position in
            crabs.map({ crabPos in
                return abs(position - crabPos)
            }).sum
        }).reduce(Int.max, min)

        print("Part 1: They must spend \(minCost1) fuel to align to the final position.")


        // Part 2

        let minCost2 = crabs.indices.map({ position in
            crabs.map({ crabPos in
                let diff = abs(position - crabPos)
                // formula for 1 + 2 + ... + diff
                let fuelCost = diff * (diff + 1) / 2
                return fuelCost
            }).sum
        }).reduce(Int.max, min)

        print("Part 2: They must spend \(minCost2) fuel to align to the final position.")


        return (part1: "\(minCost1)", part2: "\(minCost2)")
    }

}
