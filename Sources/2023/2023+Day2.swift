import Algorithms
import RegexBuilder


extension Challenges2023 {

    private struct Cubes {
        enum Color { case red, green, blue }

        let color: Color
        let count: Int

        init(string: String) {
            let regex = Regex {
                TryCapture {
                    OneOrMore(.digit)
                } transform: {
                    Int($0)
                }
                One(.whitespace)
                TryCapture {
                    ChoiceOf {
                        "red"
                        "green"
                        "blue"
                    }
                } transform: {
                    switch $0 {
                        case "red": Color.red
                        case "green": Color.green
                        case "blue": Color.blue
                        default: fatalError()
                    }
                }
            }
            let match = string.wholeMatch(of: regex)!.output
            self.count = match.1
            self.color = match.2
        }
    }

    private struct Pull {
        let cubes: [Cubes]

        init(string: String) {
            self.cubes = string.split(separator: /,\s/).map { Cubes(string: String($0)) }
        }

        static func parse(line: String) -> [Pull] {
            line.split(separator: /;\s/).map { Pull(string: String($0)) }
        }
    }

    private struct Game {
        let id: Int
        let pulls: [Pull]

        init(line: String) {
            //Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
            let regex = /Game (?<id>\d+): (?<pulls>.*)/
            let match = line.wholeMatch(of: regex)!
            self.id = Int(match.output.id)!
            self.pulls = Pull.parse(line: String(match.output.pulls))
        }

        func isPossible(maxReds: Int, maxGreens: Int, maxBlues: Int) -> Bool {
            let numReds = self.pulls.flatMap(\.cubes).filter({ $0.color == .red }).map(\.count).max()!
            let numGreens = self.pulls.flatMap(\.cubes).filter({ $0.color == .green }).map(\.count).max()!
            let numBlues = self.pulls.flatMap(\.cubes).filter({ $0.color == .blue }).map(\.count).max()!
            return numReds <= maxReds && numGreens <= maxGreens && numBlues <= maxBlues
        }

        var power: Int {
            let maxReds = self.pulls.flatMap(\.cubes).filter({ $0.color == .red }).map(\.count).max()!
            let maxGreens = self.pulls.flatMap(\.cubes).filter({ $0.color == .green }).map(\.count).max()!
            let maxBlues = self.pulls.flatMap(\.cubes).filter({ $0.color == .blue }).map(\.count).max()!
            return maxReds * maxGreens * maxBlues
        }
    }

    

    @discardableResult static func runDay2(input: Input) async throws -> ChallengeResult {
        let games = input.lines().map(Game.init)

        let part1 = games.filter({ $0.isPossible(maxReds: 12, maxGreens: 13, maxBlues: 14) }).map(\.id).sum
        print("Part 1: The sum of IDs of possible games is \(part1)")

        let part2 = games.map(\.power).sum
        print("Part 2: The sum all games' Power is \(part2)")

        return ("\(part1)", "\(part2)")
    }


}
