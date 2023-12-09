extension Challenges2021 {

    private final class Octopus {

        private(set) var energy: Int
        private(set) var numFlashes = 0

        init(energy: Int) {
            self.energy = energy
        }

        func increaseEnergy() -> Bool {
            self.energy += 1
            if self.energy == 10 {
                numFlashes += 1
                return true
            } else {
                return false
            }
        }

        func reset() {
            if self.energy > 9 {
                self.energy = 0
            }
        }

    }

    @discardableResult static func runDay11(input: Input) async throws -> ChallengeResult {
        let octopuses = Grid(input.lines().map({ $0.map({ Octopus(energy: Int(String($0))!) }) }))

        var flashesAfter100 = 0
        var stepsUntilFullFlash = 0

        var steps = 0
        while true {
            steps += 1
            var flashingOctopuses = octopuses.allPoints.compactMap({ $0.value.increaseEnergy() ? $0 : nil })
            var octopusesFlashedThisTurn = Set(flashingOctopuses)

            while !flashingOctopuses.isEmpty {
                let neighbors = flashingOctopuses.flatMap({ octopuses.getNeighbors($0) })
                flashingOctopuses = neighbors.compactMap({ $0.value.increaseEnergy() ? $0 : nil })
                octopusesFlashedThisTurn = octopusesFlashedThisTurn.union(flashingOctopuses)
            }
            octopuses.allPoints.forEach({ $0.value.reset() })

            if steps == 100 {
                flashesAfter100 = octopuses.allValues.map(\.numFlashes).sum
                if stepsUntilFullFlash != 0 { break }
            }
            if octopusesFlashedThisTurn.count == octopuses.allPoints.count {
                stepsUntilFullFlash = steps
                if steps >= 100 { break }
            }
        }

        print("Part 1: There are \(flashesAfter100) total flashes after 100 steps.")
        print("Part 2: \(stepsUntilFullFlash) is the first step during which all octopuses flash.")

        return (part1: "\(flashesAfter100)", part2: "\(stepsUntilFullFlash)")
    }

}
