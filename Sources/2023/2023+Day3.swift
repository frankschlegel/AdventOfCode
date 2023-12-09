import RegexBuilder


extension Challenges2023 {

    private struct Number {
        let value: Int
        let surrounding: [[String].Index: Substring]

        var isPartNumber: Bool {
            self.surrounding.values.joined().contains(/[^\.\d]/)
        }

        var gears: [Gear] {
            self.surrounding.flatMap { lineIndex, substring in
                zip(substring, substring.indices).filter({ $0.0 == "*" }).map({ Gear(x: $0.1, y: lineIndex) })
            }
        }
    }

    private struct Gear: Hashable {
        let x: String.Index
        let y: [String].Index
    }

    @discardableResult static func runDay3(input: Input) async throws -> ChallengeResult {
        let regex = Regex {
            TryCapture {
                OneOrMore(.digit)
            } transform: {
                Int($0)
            }
        }
        let lines = input.lines()
        let numbers = zip(lines, lines.indices).flatMap { line, index in
            let matches = line.matches(of: regex)
            return matches.map { match in
                let indexBefore = line.index(match.range.lowerBound, offsetBy: -1, limitedBy: line.startIndex) ?? line.startIndex
                let indexAfter = line.index(match.range.upperBound, offsetBy: 1, limitedBy: line.endIndex) ?? line.endIndex
                let range = indexBefore..<indexAfter
                var surrounding = [[String].Index: Substring]()
                if let indexBefore = lines.index(index, offsetBy: -1, limitedBy: lines.startIndex) {
                    surrounding[indexBefore] = lines[indexBefore][range]
                }
                surrounding[index] = line[range]
                if let indexAfter = lines.index(index, offsetBy: 1, limitedBy: lines.index(before: lines.endIndex)) {
                    surrounding[indexAfter] = lines[indexAfter][range]
                }
                return Number(value: match.1, surrounding: surrounding)
            }
        }

        let partNumbers = numbers.filter(\.isPartNumber)
        let part1 = partNumbers.map(\.value).sum
        print("Part 1: The sum of all part numbers is \(part1)")

        let gearMap = numbers.reduce([Gear: [Number]]()) { map, number in
            var map = map
            for gear in number.gears {
                var numbers = map[gear] ?? []
                numbers.append(number)
                map[gear] = numbers
            }
            return map
        }
        let validGears = gearMap.filter({ $0.value.count == 2 })
        let gearRatios = validGears.values.map({ $0[0].value * $0[1].value })
        let part2 = gearRatios.sum
        print("Part 2: The sum gear ratios is \(part2)")

        return ("\(part1)", "\(part2)")
    }

}
