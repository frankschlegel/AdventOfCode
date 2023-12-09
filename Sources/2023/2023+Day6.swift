import RegexBuilder


extension Challenges2023 {

    private struct Race {
        let time: Int
        let distanceRecord: Int

        var numBeatingWays: Int {
            let buttonHoldingPossibilities = (1..<self.time).striding(by: 1)
            func beatsRecord(_ holdDownTime: Int) -> Bool {
                let velocity = holdDownTime
                let remainingTime = self.time - holdDownTime
                let reachedDistance = remainingTime * velocity
                return reachedDistance > self.distanceRecord
            }

            let minHoldingTime = buttonHoldingPossibilities.first(where: beatsRecord(_:))!
            let maxHoldingTime = buttonHoldingPossibilities.reversed().first(where: beatsRecord(_:))!

            return maxHoldingTime - minHoldingTime + 1
        }
    }

    @discardableResult static func runDay6(input: Input) async throws -> ChallengeResult {
        let lines = input.lines()

        let timesString = lines[0].wholeMatch(of: /Time:\s+([\d\s]+)/)!.output.1.replacing(/\s+/, with: " ")
        let distanceString = lines[1].wholeMatch(of: /Distance:\s+([\d\s]+)/)!.output.1.replacing(/\s+/, with: " ")
        let times = timesString.numbers
        let distances = distanceString.numbers
        let races = zip(times, distances).map { Race(time: $0.0, distanceRecord: $0.1) }

        let part1 = races.map(\.numBeatingWays).product
        print("Part 1: The product of the numbers of ways to beat the record is \(part1)")

        let timePart2 = Int(timesString.replacing(/\s+/, with: ""))!
        let distancePart2 = Int(distanceString.replacing(/\s+/, with: ""))!
        let racePart2 = Race(time: timePart2, distanceRecord: distancePart2)

        let part2 = racePart2.numBeatingWays
        print("Part 1: The numbers of ways to beat the longer race is \(part2)")

        return ("\(part1)", "\(part2)")
    }

}
