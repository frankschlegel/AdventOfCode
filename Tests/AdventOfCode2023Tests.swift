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

}
