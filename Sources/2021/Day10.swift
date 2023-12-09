extension Challenges2021 {

    private static func findIllegalCharacter(in line: String) -> Character? {
        var openingBraces = [Character]()
        for character in line {
            if character.isOpeningBrace {
                openingBraces.append(character)
            } else if let last = openingBraces.popLast(), character.isClosingBrace(for: last) {
                continue
            } else {
                return character
            }
        }
        return nil
    }

    private static func findMissingClosingBraces(in line: String) -> String {
        var openingBraces = [Character]()
        for character in line {
            if character.isOpeningBrace {
                openingBraces.append(character)
            } else if let last = openingBraces.popLast(), character.isClosingBrace(for: last) {
                continue
            }
        }
        return String(openingBraces.reversed().map(\.matchingClosingBrace))
    }

    @discardableResult static func runDay10(input: Input) async throws -> ChallengeResult {
        let lines = input.lines()


        // Part 1

        let illegalCharacters = lines.compactMap({ self.findIllegalCharacter(in: $0) })
        let score = illegalCharacters.map(\.errorScore).sum

        print("Part 1: The total syntax error score is \(score).")


        // Part 2

        let legalLines = lines.filter({ self.findIllegalCharacter(in: $0) == nil })
        let missingClosingBraces = legalLines.map({ self.findMissingClosingBraces(in: $0) })
        let scores = missingClosingBraces.map(\.score)
        let median = scores.sorted()[scores.count / 2]

        print("Part 2: The middle score is \(median).")


        return (part1: "\(score)", part2: "\(median)")
    }

}


private extension Character {

    var isOpeningBrace: Bool {
        return ["(", "[", "{", "<"].contains(self)
    }

    var isClosingBrace: Bool {
        return [")", "]", "}", ">"].contains(self)
    }

    func isClosingBrace(for openingBrace: Self) -> Bool {
        switch self {
            case ")": return openingBrace == "("
            case "]": return openingBrace == "["
            case "}": return openingBrace == "{"
            case ">": return openingBrace == "<"
            default: return false
        }
    }

    var matchingClosingBrace: Self {
        switch self {
            case "(": return ")"
            case "[": return "]"
            case "{": return "}"
            case "<": return ">"
            default: fatalError()
        }
    }

    var errorScore: Int {
        switch self {
            case ")": return 3
            case "]": return 57
            case "}": return 1197
            case ">": return 25137
            default: return 0
        }
    }

    var pointValue: Int {
        switch self {
            case ")": return 1
            case "]": return 2
            case "}": return 3
            case ">": return 4
            default: return 0
        }
    }

}

private extension String {

    var score: Int {
        return self.reduce(0) { partialResult, character in
            return partialResult * 5 + character.pointValue
        }
    }

}
