@testable import AdventOfCode
import XCTest


final class AdventOfCode2023Tests: XCTestCase {

    func testDay1() async throws {
        let input1 = TestInput(string: """
            1abc2
            pqr3stu8vwx
            a1b2c3d4e5f
            treb7uchet
            """)
        let result1 = try await Challenges2023.runDay1(input: input1)
        XCTAssertEqual(result1.part1, "142")

        let input2 = TestInput(string: """
            two1nine
            eightwothree
            abcone2threexyz
            xtwone3four
            4nineeightseven2
            zoneight234
            7pqrstsixteen
            """)
        let result2 = try await Challenges2023.runDay1(input: input2)
        XCTAssertEqual(result2.part2, "281")

        let input3 = TestInput(string: """
            eighthree
            sevenine
            tfphzkcxh3twofour9oneightg
            """)
        let result3 = try await Challenges2023.runDay1(input: input3)
        XCTAssertEqual(result3.part2, "200")
    }

    func testDay2() async throws {
        let input1 = TestInput(string: """
            Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green
            Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue
            Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red
            Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red
            Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green
            """)
        let result1 = try await Challenges2023.runDay2(input: input1)
        XCTAssertEqual(result1.part1, "8")
        XCTAssertEqual(result1.part2, "2286")
    }

    func testDay3() async throws {
        let input1 = TestInput(string: """
            467..114..
            ...*......
            ..35..633.
            ......#...
            617*......
            .....+.58.
            ..592.....
            ......755.
            ...$.*....
            .664.598..
            """)
        let result1 = try await Challenges2023.runDay3(input: input1)
        XCTAssertEqual(result1.part1, "4361")
        XCTAssertEqual(result1.part2, "467835")
    }

}
