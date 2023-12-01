import ArgumentParser
import Foundation


@main
struct AdventOfCode: ParsableCommand {

    enum RuntimeError: Error {
        case parsingError
    }

    @Option(name: .shortAndLong, help: "The challenge year. Uses the current year by default.")
    var year: UInt = Date().currentYearInEST

    @Option(name: .shortAndLong, help: "The challenge day. Uses the current day by default.")
    var day: UInt8 = Date().currentDayInEST

    @Option(name: .shortAndLong, help: "Your session cookie on https://adventofcode.com. This is needed to download your personal puzzle inputs.")
    var session: String


    mutating func run() throws {
        print("Running day \(self.day) of year \(self.year)...")
        print("")

        Task { [year = self.year, day = self.day, session = self.session] in
            do {
                let input = try await ChallengeInput(year: year, day: day, session: session)
                switch year {
                    case 2015: try await Challenges2015.run(day: day, input: input)
                    case 2016: try await Challenges2016.run(day: day, input: input)
                    case 2017: try await Challenges2017.run(day: day, input: input)
                    case 2018: try await Challenges2018.run(day: day, input: input)
                    case 2019: try await Challenges2019.run(day: day, input: input)
                    case 2020: try await Challenges2020.run(day: day, input: input)
                    case 2021: try await Challenges2021.run(day: day, input: input)
                    case 2022: try await Challenges2022.run(day: day, input: input)
                    case 2023: try await Challenges2023.run(day: day, input: input)
                    default: throw ValidationError("No challenges available for this year.")
                }
            } catch {
                Self.exit(withError: error)
            }
            Self.exit()
        }

        // keep running while work happens async
        RunLoop.main.run()
    }

}


extension Date {

    var currentDayInEST: UInt8 {
        let day = self.string(for: "d", timeZone: "EST")
        return UInt8(day)!
    }

    var currentYearInEST: UInt {
        let year = self.string(for: "yyyy", timeZone: "EST")
        return UInt(year)!
    }

    private func string(for format: String, timeZone: String) -> String {
        let dateFormatter = DateFormatter()
        // use the time zone where new challenges go live at midnight
        dateFormatter.timeZone = TimeZone(abbreviation: timeZone)
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}
