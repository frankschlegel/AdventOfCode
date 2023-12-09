import RegexBuilder


private typealias Card = Character
private extension Card {
    static let cardOrder: [Card] = ["2", "3", "4", "5", "6", "7", "8", "9", "T", "J", "Q", "K", "A"]
    static let cardOrderWithJoker: [Card] = ["J", "2", "3", "4", "5", "6", "7", "8", "9", "T", "Q", "K", "A"]
    var strength: Int { Self.cardOrder.firstIndex(of: self)! }
    var strengthWithJoker: Int { Self.cardOrderWithJoker.firstIndex(of: self)! }
}

private struct Hand {
    
    enum `Type`: Int {
        case highCard
        case onePair
        case twoPair
        case threeOfAKind
        case fullHouse
        case fourOfAKind
        case fiveOfAKind

        init(cards: [Card]) {
            let groupedCards = cards.sorted().chunked(by: { $0 == $1 })
            if groupedCards.count == 1 {
                self = .fiveOfAKind
            } else if groupedCards.contains(where: { $0.count == 4 }) {
                self = .fourOfAKind
            } else if groupedCards.contains(where: { $0.count == 3 }) && groupedCards.contains(where: { $0.count == 2 }) {
                self = .fullHouse
            } else if groupedCards.contains(where: { $0.count == 3 }) {
                self = .threeOfAKind
            } else if groupedCards.filter({ $0.count == 2 }).count == 2 {
                self = .twoPair
            } else if groupedCards.contains(where: { $0.count == 2 }) {
                self = .onePair
            } else {
                self = .highCard
            }
        }

        static func bestWithJokers(in cards: [Card]) -> Self {
            let groupedOtherCards = cards.filter({ $0 != "J" }).sorted().chunked(by: { $0 == $1 })
            if !groupedOtherCards.isEmpty, let mostCommonCard = groupedOtherCards.max(by: { $0.count < $1.count })!.first {
                let newCards = cards.replacing(["J"], with: [mostCommonCard])
                return Self(cards: newCards)
            } else {
                return Self(cards: cards)
            }
        }
    }

    let cards: [Card]
    let type: Type
    let bid: Int
    let withJokers: Bool

    init(cards: [Card], bid: Int, withJokers: Bool = false) {
        self.cards = cards
        self.type = withJokers ? Type.bestWithJokers(in: cards) : Type(cards: cards)
        self.bid = bid
        self.withJokers = withJokers
    }

    init(_ string: String, withJokers: Bool = false) {
        let parts = string.split(separator: " ")
        let cards = parts[0].map(Card.init)
        let bid = Int(parts[1])!
        self.init(cards: cards, bid: bid, withJokers: withJokers)
    }

}

extension Hand: Comparable {
    static func < (lhs: Hand, rhs: Hand) -> Bool {
        if lhs.type.rawValue != rhs.type.rawValue {
            return lhs.type.rawValue < rhs.type.rawValue
        } else {
            for (lhsCard, rhsCard) in zip(lhs.cards, rhs.cards) {
                if lhs.withJokers {
                    if lhsCard.strengthWithJoker != rhsCard.strengthWithJoker { return lhsCard.strengthWithJoker < rhsCard.strengthWithJoker }
                } else {
                    if lhsCard.strength != rhsCard.strength { return lhsCard.strength < rhsCard.strength }
                }
            }
        }
        return false
    }
    

}


extension Challenges2023 {

    @discardableResult static func runDay7(input: Input) async throws -> ChallengeResult {
        let handsPart1 = input.lines().map { Hand($0, withJokers: false) }
        let sortedHandsPart1 = handsPart1.sorted()
        let rankedHandsPart1 = zip(sortedHandsPart1, sortedHandsPart1.indices)
        let part1 = rankedHandsPart1.map({ ($0.1 + 1) * $0.0.bid }).sum
        print("The total winnings of the hands is \(part1)")

        let handsPart2 = input.lines().map { Hand($0, withJokers: true) }
        let sortedHandsPart2 = handsPart2.sorted()
        let rankedHandsPart2 = zip(sortedHandsPart2, sortedHandsPart2.indices)
        let part2 = rankedHandsPart2.map({ ($0.1 + 1) * $0.0.bid }).sum
        print("The total winnings of the hands with jokes is \(part2)")

        return ("\(part1)", "\(part2)")
    }

}
