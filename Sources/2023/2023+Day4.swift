import Numerics
import RegexBuilder


extension Challenges2023 {

    private struct Card: Hashable {
        let id: Int
        let winningNumbers: [Int]
        let numbersYouHave: [Int]

        init(string: String) {
            let regex = Regex {
                "Card"
                OneOrMore(.whitespace)
                TryCapture {
                    OneOrMore(.digit)
                } transform: { Int($0) }
                ":"
                TryCapture {
                    OneOrMore {
                        CharacterClass(
                            .digit,
                            .whitespace
                        )
                    }
                } transform: { numbers in
                    String(numbers).trimmingCharacters(in: .whitespaces).numbers()
                }
                "|"
                TryCapture {
                    OneOrMore {
                        CharacterClass(
                            .digit,
                            .whitespace
                        )
                    }
                } transform: { numbers in
                    String(numbers).trimmingCharacters(in: .whitespaces).numbers()
                }
            }

            let match = string.wholeMatch(of: regex)!.output
            self.id = match.1
            self.winningNumbers = match.2
            self.numbersYouHave = match.3
        }

        var value: Int {
            if self.matches == 0 { return 0 }
            return Int(Double.pow(2.0, matches - 1))
        }

        var matches: Int {
            self.numbersYouHave.filter { self.winningNumbers.contains($0) }.count
        }

    }

    private static func collectCopies(of cards: [Card], cardCopyMap: [Card: [Card]]) -> [Card] {
        let copies = cards.flatMap { cardCopyMap[$0]! }
        if copies.isEmpty { return cards }
        return cards + collectCopies(of: copies, cardCopyMap: cardCopyMap)
    }

    @discardableResult static func runDay4(input: Input) async throws -> ChallengeResult {
        let cards = input.lines().map(Card.init)

        let part1 = cards.map(\.value).sum
        print("Part 1: The sum of all card values is \(part1)")

        var cardCopyMap = [Card: [Card]]()
        for card in cards {
            cardCopyMap[card] = Array(cards[card.id..<min(card.id + card.matches, cards.endIndex)])
        }

        let part2 = collectCopies(of: cards, cardCopyMap: cardCopyMap).count
        print("Part 2: The total number of cards won is \(part2)")

        return ("\(part1)", "\(part2)")
    }

}
