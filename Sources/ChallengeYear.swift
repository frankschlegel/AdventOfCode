import ArgumentParser


/// Helper type for running specific daily challenges of the implementing year.
protocol ChallengeYear {

    /// Return type for all challenge runs.
    /// Uses `String` as generic return type since we don't know the results of the specific challenge,
    /// but the AoC website always has a text input field for the result.
    typealias ChallengeResult = (part1: String, part2: String)

    @discardableResult static func runDay1(input: Input) async throws -> ChallengeResult
    @discardableResult static func runDay2(input: Input) async throws -> ChallengeResult
    @discardableResult static func runDay3(input: Input) async throws -> ChallengeResult
    @discardableResult static func runDay4(input: Input) async throws -> ChallengeResult
    @discardableResult static func runDay5(input: Input) async throws -> ChallengeResult
    @discardableResult static func runDay6(input: Input) async throws -> ChallengeResult
    @discardableResult static func runDay7(input: Input) async throws -> ChallengeResult
    @discardableResult static func runDay8(input: Input) async throws -> ChallengeResult
    @discardableResult static func runDay9(input: Input) async throws -> ChallengeResult
    @discardableResult static func runDay10(input: Input) async throws -> ChallengeResult
    @discardableResult static func runDay11(input: Input) async throws -> ChallengeResult
    @discardableResult static func runDay12(input: Input) async throws -> ChallengeResult
    @discardableResult static func runDay13(input: Input) async throws -> ChallengeResult
    @discardableResult static func runDay14(input: Input) async throws -> ChallengeResult
    @discardableResult static func runDay15(input: Input) async throws -> ChallengeResult
    @discardableResult static func runDay16(input: Input) async throws -> ChallengeResult
    @discardableResult static func runDay17(input: Input) async throws -> ChallengeResult
    @discardableResult static func runDay18(input: Input) async throws -> ChallengeResult
    @discardableResult static func runDay19(input: Input) async throws -> ChallengeResult
    @discardableResult static func runDay20(input: Input) async throws -> ChallengeResult
    @discardableResult static func runDay21(input: Input) async throws -> ChallengeResult
    @discardableResult static func runDay22(input: Input) async throws -> ChallengeResult
    @discardableResult static func runDay23(input: Input) async throws -> ChallengeResult
    @discardableResult static func runDay24(input: Input) async throws -> ChallengeResult
    @discardableResult static func runDay25(input: Input) async throws -> ChallengeResult

}


// Placeholder challenges for specific years.
// The actual implementation happens in extensions.
enum Challenges2015: ChallengeYear {}
enum Challenges2016: ChallengeYear {}
enum Challenges2017: ChallengeYear {}
enum Challenges2018: ChallengeYear {}
enum Challenges2019: ChallengeYear {}
enum Challenges2020: ChallengeYear {}
enum Challenges2021: ChallengeYear {}
enum Challenges2022: ChallengeYear {}
enum Challenges2023: ChallengeYear {}


// Some default implementations that are used when a challenge is not yet implemented.
extension ChallengeYear {

    @discardableResult static func runDay1(input: Input) async throws -> ChallengeResult { print("Not yet implemented."); throw ExitCode.failure }
    @discardableResult static func runDay2(input: Input) async throws -> ChallengeResult { print("Not yet implemented."); throw ExitCode.failure }
    @discardableResult static func runDay3(input: Input) async throws -> ChallengeResult { print("Not yet implemented."); throw ExitCode.failure }
    @discardableResult static func runDay4(input: Input) async throws -> ChallengeResult { print("Not yet implemented."); throw ExitCode.failure }
    @discardableResult static func runDay5(input: Input) async throws -> ChallengeResult { print("Not yet implemented."); throw ExitCode.failure }
    @discardableResult static func runDay6(input: Input) async throws -> ChallengeResult { print("Not yet implemented."); throw ExitCode.failure }
    @discardableResult static func runDay7(input: Input) async throws -> ChallengeResult { print("Not yet implemented."); throw ExitCode.failure }
    @discardableResult static func runDay8(input: Input) async throws -> ChallengeResult { print("Not yet implemented."); throw ExitCode.failure }
    @discardableResult static func runDay9(input: Input) async throws -> ChallengeResult { print("Not yet implemented."); throw ExitCode.failure }
    @discardableResult static func runDay10(input: Input) async throws -> ChallengeResult { print("Not yet implemented."); throw ExitCode.failure }
    @discardableResult static func runDay11(input: Input) async throws -> ChallengeResult { print("Not yet implemented."); throw ExitCode.failure }
    @discardableResult static func runDay12(input: Input) async throws -> ChallengeResult { print("Not yet implemented."); throw ExitCode.failure }
    @discardableResult static func runDay13(input: Input) async throws -> ChallengeResult { print("Not yet implemented."); throw ExitCode.failure }
    @discardableResult static func runDay14(input: Input) async throws -> ChallengeResult { print("Not yet implemented."); throw ExitCode.failure }
    @discardableResult static func runDay15(input: Input) async throws -> ChallengeResult { print("Not yet implemented."); throw ExitCode.failure }
    @discardableResult static func runDay16(input: Input) async throws -> ChallengeResult { print("Not yet implemented."); throw ExitCode.failure }
    @discardableResult static func runDay17(input: Input) async throws -> ChallengeResult { print("Not yet implemented."); throw ExitCode.failure }
    @discardableResult static func runDay18(input: Input) async throws -> ChallengeResult { print("Not yet implemented."); throw ExitCode.failure }
    @discardableResult static func runDay19(input: Input) async throws -> ChallengeResult { print("Not yet implemented."); throw ExitCode.failure }
    @discardableResult static func runDay20(input: Input) async throws -> ChallengeResult { print("Not yet implemented."); throw ExitCode.failure }
    @discardableResult static func runDay21(input: Input) async throws -> ChallengeResult { print("Not yet implemented."); throw ExitCode.failure }
    @discardableResult static func runDay22(input: Input) async throws -> ChallengeResult { print("Not yet implemented."); throw ExitCode.failure }
    @discardableResult static func runDay23(input: Input) async throws -> ChallengeResult { print("Not yet implemented."); throw ExitCode.failure }
    @discardableResult static func runDay24(input: Input) async throws -> ChallengeResult { print("Not yet implemented."); throw ExitCode.failure }
    @discardableResult static func runDay25(input: Input) async throws -> ChallengeResult { print("Not yet implemented."); throw ExitCode.failure }


    /// Convenient helper for running the corresponding challenge for the given day.
    static func run(day: UInt8, input: Input) async throws {
        switch day {
            case 1: try await self.runDay1(input: input)
            case 2: try await self.runDay2(input: input)
            case 3: try await self.runDay3(input: input)
            case 4: try await self.runDay4(input: input)
            case 5: try await self.runDay5(input: input)
            case 6: try await self.runDay6(input: input)
            case 7: try await self.runDay7(input: input)
            case 8: try await self.runDay8(input: input)
            case 9: try await self.runDay9(input: input)
            case 10: try await self.runDay10(input: input)
            case 11: try await self.runDay11(input: input)
            case 12: try await self.runDay12(input: input)
            case 13: try await self.runDay13(input: input)
            case 14: try await self.runDay14(input: input)
            case 15: try await self.runDay15(input: input)
            case 16: try await self.runDay16(input: input)
            case 17: try await self.runDay17(input: input)
            case 18: try await self.runDay18(input: input)
            case 19: try await self.runDay19(input: input)
            case 20: try await self.runDay20(input: input)
            case 21: try await self.runDay21(input: input)
            case 22: try await self.runDay22(input: input)
            case 23: try await self.runDay23(input: input)
            case 24: try await self.runDay24(input: input)
            case 25: try await self.runDay25(input: input)
            default: throw ValidationError("Invalid day")
        }
    }

}
