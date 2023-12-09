extension Challenges2021 {

    @discardableResult static func runDay3(input: Input) async throws -> ChallengeResult {
        let linesAsNumbers = input.lines().map({ String($0).map({ Int(String($0))! }) })

        let sums = linesAsNumbers.dropFirst().reduce(linesAsNumbers.first!) { result, next -> [Int] in
            return zip(result, next).map({ $0.0 + $0.1 })
        }

        let discriminator = linesAsNumbers.count / 2

        let mostCommon = sums.map({ $0 >= discriminator ? 1 : 0 })
        let mostCommonString = mostCommon.map(String.init).joined()
        let gammaRate = UInt(mostCommonString, radix: 2)!

        let leastCommon = sums.map({ $0 >= discriminator ? 0 : 1 })
        let leastCommonString = leastCommon.map(String.init).joined()
        let epsilonRate = UInt(leastCommonString, radix: 2)!

        print("Part 1: The power consumption of the submarine is \(gammaRate * epsilonRate).")

        var remainingOxygenValues = Array(linesAsNumbers)
        for index in remainingOxygenValues.first!.indices {
            let sum = remainingOxygenValues.map({ $0[index] }).sum
            let mostCommonValue = sum >= (remainingOxygenValues.count / 2 + remainingOxygenValues.count % 2) ? 1 : 0
            remainingOxygenValues = remainingOxygenValues.filter({ $0[index] == mostCommonValue })
            if remainingOxygenValues.count == 1 { break }
        }
        let oxygenValue = UInt(remainingOxygenValues.first!.map(String.init).joined(), radix: 2)!

        var remainingCO2Values = Array(linesAsNumbers)
        for index in remainingCO2Values.first!.indices {
            let sum = remainingCO2Values.map({ $0[index] }).sum
            let leastCommonValue = sum >= (remainingCO2Values.count / 2 + remainingCO2Values.count % 2) ? 0 : 1
            remainingCO2Values = remainingCO2Values.filter({ $0[index] == leastCommonValue })
            if remainingCO2Values.count == 1 { break }
        }
        let co2Value = UInt(remainingCO2Values.first!.map(String.init).joined(), radix: 2)!

        print("Part 2: The life support rating of the submarine is \(oxygenValue * co2Value).")

        return (part1: "\(gammaRate * epsilonRate)", part2: "\(oxygenValue * co2Value)")
    }

}
