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

    func testDay4() async throws {
        let input1 = TestInput(string: """
            Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
            Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
            Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
            Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
            Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
            Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
            """)
        let result1 = try await Challenges2023.runDay4(input: input1)
        XCTAssertEqual(result1.part1, "13")
        XCTAssertEqual(result1.part2, "30")
    }

    func testDay5() async throws {
        let input1 = TestInput(string: """
            seeds: 79 14 55 13

            seed-to-soil map:
            50 98 2
            52 50 48

            soil-to-fertilizer map:
            0 15 37
            37 52 2
            39 0 15

            fertilizer-to-water map:
            49 53 8
            0 11 42
            42 0 7
            57 7 4

            water-to-light map:
            88 18 7
            18 25 70

            light-to-temperature map:
            45 77 23
            81 45 19
            68 64 13

            temperature-to-humidity map:
            0 69 1
            1 0 69

            humidity-to-location map:
            60 56 37
            56 93 4
            """)
        let result1 = try await Challenges2023.runDay5(input: input1)
        XCTAssertEqual(result1.part1, "35")
        XCTAssertEqual(result1.part2, "46")
    }

    func testDay6() async throws {
        let input1 = TestInput(string: """
            Time:      7  15   30
            Distance:  9  40  200
            """)
        let result1 = try await Challenges2023.runDay6(input: input1)
        XCTAssertEqual(result1.part1, "288")
        XCTAssertEqual(result1.part2, "71503")
    }

    func testDay7() async throws {
        let input1 = TestInput(string: """
            32T3K 765
            T55J5 684
            KK677 28
            KTJJT 220
            QQQJA 483
            """)
        let result1 = try await Challenges2023.runDay7(input: input1)
        XCTAssertEqual(result1.part1, "6440")
        XCTAssertEqual(result1.part2, "5905")

        let input2 = TestInput(string: """
            AAAAA 2
            AA8AA 3
            23332 5
            TTT98 7
            23432 11
            A23A4 13
            23456 17
            """)
        let result2 = try await Challenges2023.runDay7(input: input2)
        XCTAssertEqual(result2.part1, "161")
        XCTAssertEqual(result2.part2, "161")
    }

    func testDay8() async throws {
        let input1 = TestInput(string: """
            RL

            AAA = (BBB, CCC)
            BBB = (DDD, EEE)
            CCC = (ZZZ, GGG)
            DDD = (DDD, DDD)
            EEE = (EEE, EEE)
            GGG = (GGG, GGG)
            ZZZ = (ZZZ, ZZZ)
            """)
        let result1 = try await Challenges2023.runDay8(input: input1)
        XCTAssertEqual(result1.part1, "2")
        XCTAssertEqual(result1.part2, "2")

        let input2 = TestInput(string: """
            LLR

            AAA = (BBB, BBB)
            BBB = (AAA, ZZZ)
            ZZZ = (ZZZ, ZZZ)
            """)
        let result2 = try await Challenges2023.runDay8(input: input2)
        XCTAssertEqual(result2.part1, "6")

        let input3 = TestInput(string: """
            LR

            11A = (11B, XXX)
            11B = (XXX, 11Z)
            11Z = (11B, XXX)
            22A = (22B, XXX)
            22B = (22C, 22C)
            22C = (22Z, 22Z)
            22Z = (22B, 22B)
            XXX = (XXX, XXX)
            """)
        let result3 = try await Challenges2023.runDay8(input: input3)
        XCTAssertEqual(result3.part2, "6")
    }

    func testDay9() async throws {
        let input1 = TestInput(string: """
            0 3 6 9 12 15
            1 3 6 10 15 21
            10 13 16 21 30 45
            """)
        let result1 = try await Challenges2023.runDay9(input: input1)
        XCTAssertEqual(result1.part1, "114")
        XCTAssertEqual(result1.part2, "2")
    }

    func testDay10() async throws {
        let input1 = TestInput(string: """
            -L|F7
            7S-7|
            L|7||
            -L-J|
            L|-JF
            """)
        let result1 = try await Challenges2023.runDay10(input: input1)
        XCTAssertEqual(result1.part1, "4")
        XCTAssertEqual(result1.part2, "1")

        let input2 = TestInput(string: """
            7-F7-
            .FJ|7
            SJLL7
            |F--J
            LJ.LJ
            """)
        let result2 = try await Challenges2023.runDay10(input: input2)
        XCTAssertEqual(result2.part1, "8")
        XCTAssertEqual(result2.part2, "1")

        let input3 = TestInput(string: """
            ...........
            .S-------7.
            .|F-----7|.
            .||.....||.
            .||.....||.
            .|L-7.F-J|.
            .|..|.|..|.
            .L--J.L--J.
            ...........
            """)
        let result3 = try await Challenges2023.runDay10(input: input3)
        XCTAssertEqual(result3.part2, "4")

        let input4 = TestInput(string: """
            .F----7F7F7F7F-7....
            .|F--7||||||||FJ....
            .||.FJ||||||||L7....
            FJL7L7LJLJ||LJ.L-7..
            L--J.L7...LJS7F-7L7.
            ....F-J..F7FJ|L7L7L7
            ....L7.F7||L7|.L7L7|
            .....|FJLJ|FJ|F7|.LJ
            ....FJL-7.||.||||...
            ....L---J.LJ.LJLJ...
            """)
        let result4 = try await Challenges2023.runDay10(input: input4)
        XCTAssertEqual(result4.part2, "8")
    }

}
