import Foundation


/// Helper type for fetching the personalized puzzle input from the server.
struct ChallengeInput {

    let data: Data

    init(year: UInt, day: UInt8, session: String) async throws {
        let fileManager = FileManager.default
        // check if we have already downloaded the data
        let cachedFilePath = fileManager.temporaryDirectory.appendingPathComponent("AoC_\(year)_\(day)_\(session).input")
        if fileManager.fileExists(atPath: cachedFilePath.relativePath) {
            self.data = fileManager.contents(atPath: cachedFilePath.relativePath)!
        // if not, download and cache the data
        } else {
            let url = URL(string: "https://adventofcode.com/\(year)/day/\(day)/input")!

            var request = URLRequest(url: url)
            request.addValue("session=\(session)", forHTTPHeaderField: "Cookie")
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                throw URLError(URLError.Code(rawValue: httpResponse.statusCode))
            }

            try data.write(to: cachedFilePath)
            self.data = data
        }
    }

    func asString() -> String? {
        return String(data: self.data, encoding: .utf8)
    }

    func lines() -> LazyMapSequence<LazySequence<[String.SubSequence]>.Elements, String>? {
        return self.asString()?.split(separator: "\n").lazy.map(String.init)
    }

}
