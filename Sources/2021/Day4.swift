import Algorithms


extension Challenges2021 {

    private struct Board {

        private let numbers: [[Int]]

        init(rows: [String]) {
            let rows = rows.map({ $0.replacingOccurrences(of: "  ", with: " ") })
            self.numbers = rows.map({ $0.split(separator: " ").map({ Int(String($0))! }) })
        }

        func row(at index: Int) -> [Int] {
            return self.numbers[index]
        }
        func column(at index: Int) -> [Int] {
            return self.numbers.map({ $0[index] })
        }
        func allNumbers() -> Set<Int> {
            return Set(self.numbers.flatMap({ $0 }))
        }

        func wins(draw: [Int]) -> Bool {
            for i in 0...(self.numbers.count - 1) {
                if Set(self.row(at: i)).isSubset(of: draw) { return true }
                if Set(self.column(at: i)).isSubset(of: draw) { return true }
            }
            return false
        }

        func score(for draw: [Int]) -> Int {
            if self.wins(draw: draw) {
                let remainingNumbers = self.allNumbers().subtracting(draw)
                let sumRemaining = remainingNumbers.sum
                return sumRemaining * draw.last!
            } else {
                return 0
            }
        }

    }


    @discardableResult static func runDay4(input: Input) async throws -> ChallengeResult {
        let lines = input.lines()
        let drawnNumbers = lines.first!.split(separator: ",").map({ Int(String($0))! })

        let allBoardRows = lines.dropFirst().filter({ !$0.isEmpty }).chunks(ofCount: 5).map(Array.init)
        let boards = allBoardRows.map(Board.init)


        // Part 1

        var score1 = 0
        for drawEnd in 4...(drawnNumbers.count - 1) {
            let draw = Array(drawnNumbers[0...drawEnd])
            if let winningBoard = boards.first(where: { $0.score(for: draw) > 0 }) {
                score1 = winningBoard.score(for: draw)
                break
            }
        }
        print("Part 1: The score of the winning board is \(score1)")


        // Part 2

        var remainingBoards = boards
        var score2 = 0
        for drawEnd in 4...(drawnNumbers.count - 1) {
            let draw = Array(drawnNumbers[0...drawEnd])
            if remainingBoards.count == 1, remainingBoards.first!.score(for: draw) != 0 {
                score2 = remainingBoards.first!.score(for: draw)
                break
            }

            remainingBoards = remainingBoards.filter({ $0.score(for: draw) == 0 })
        }
        print("Part 2: The score of the loosing board is \(score2)")

        return (part1: "\(score1)", part2: "\(score2)")
    }

}
