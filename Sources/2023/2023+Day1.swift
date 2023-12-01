import Algorithms
import RegexBuilder


extension Challenges2023 {

    @discardableResult static func runDay1(input: Input) async throws -> ChallengeResult {
        let regex = Regex {
            TryCapture {
                One(.digit)
            } transform: {
                Int($0)
            }
        }
        let part1 = input.lines().reduce(0) { prev, line in
            let matches = line.matches(of: regex)
            let first = matches.first?.1 ?? 0, last = matches.last?.1 ?? 0
            return prev + first * 10 + last
        }
        print("Part 1: The numbers add up to \(part1).")

        func cleaned(_ string: String) -> String {
            string
                .replacingOccurrences(of: "one", with: "o1e")
                .replacingOccurrences(of: "two", with: "t2o")
                .replacingOccurrences(of: "three", with: "t3e")
                .replacingOccurrences(of: "four", with: "f4r")
                .replacingOccurrences(of: "five", with: "f5e")
                .replacingOccurrences(of: "six", with: "s6x")
                .replacingOccurrences(of: "seven", with: "s7n")
                .replacingOccurrences(of: "eight", with: "e8t")
                .replacingOccurrences(of: "nine", with: "n9e")
        }

        let part2 = input.lines().reduce(0) { prev, line in
            let matches = cleaned(line).matches(of: regex)
            let first = matches.first?.1 ?? 0, last = matches.last?.1 ?? 0
            return prev + first * 10 + last
        }
        print("Part 2: The numbers add up to \(part2).")

        return ("\(part1)", "\(part2)")
    }


}
