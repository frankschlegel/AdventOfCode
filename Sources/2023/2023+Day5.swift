import RegexBuilder
import CollectionConcurrencyKit


extension Challenges2023 {

    struct MapEntry {
        let destRangeStart: Int
        let srcRangeStart: Int
        let rangeLength: Int

        init(line: String) {
            let numbers = line.split(separator: " ").map({ Int($0)! })
            self.destRangeStart = numbers[0]
            self.srcRangeStart = numbers[1]
            self.rangeLength = numbers[2]
        }

        func dest(for source: Int) -> Int {
            return (self.destRangeStart - self.srcRangeStart) + source
        }
    }

    struct Map {
        let entries: [Range<Int>: MapEntry]

        init(lines: [String]) {
            let mapEntries = lines.map(MapEntry.init)
            self.entries = Dictionary(uniqueKeysWithValues: mapEntries.map({ ($0.srcRangeStart..<($0.srcRangeStart + $0.rangeLength), $0) }))
        }

        func dest(for source: Int) -> Int {
            for (sourceRange, entry) in self.entries {
                if sourceRange.contains(source) {
                    return entry.dest(for: source)
                }
            }
            return source
        }
    }

    @discardableResult static func runDay5(input: Input) async throws -> ChallengeResult {
        let lines = input.lines()

        let seedLine = lines.first!
        let seedNumbers = String(seedLine[seedLine.index(seedLine.startIndex, offsetBy: 7 /*seeds: */)...]).split(separator: " ").map({ Int($0)! })

        let seedToSoilStart = lines.firstIndex(of: "seed-to-soil map:")!
        let soilToFertilizerStart = lines.firstIndex(of: "soil-to-fertilizer map:")!
        let fertilizerToWaterStart = lines.firstIndex(of: "fertilizer-to-water map:")!
        let waterToLightStart = lines.firstIndex(of: "water-to-light map:")!
        let lightToTemperatureStart = lines.firstIndex(of: "light-to-temperature map:")!
        let temperatureToHumidityStart = lines.firstIndex(of: "temperature-to-humidity map:")!
        let humidityToLocationStart = lines.firstIndex(of: "humidity-to-location map:")!

        let seedToSoilMap = Map(lines: Array(lines[(seedToSoilStart + 1)..<soilToFertilizerStart]))
        let soilToFertilizerMap = Map(lines: Array(lines[(soilToFertilizerStart + 1)..<fertilizerToWaterStart]))
        let fertilizerToWaterMap = Map(lines: Array(lines[(fertilizerToWaterStart + 1)..<waterToLightStart]))
        let waterToLightMap = Map(lines: Array(lines[(waterToLightStart + 1)..<lightToTemperatureStart]))
        let lightToTemperatureMap = Map(lines: Array(lines[(lightToTemperatureStart + 1)..<temperatureToHumidityStart]))
        let temperatureToHumidityMap = Map(lines: Array(lines[(temperatureToHumidityStart + 1)..<humidityToLocationStart]))
        let humidityToLocationMap = Map(lines: Array(lines[(humidityToLocationStart + 1)...]))

        @Sendable func findLocation(for seed: Int) -> Int {
            let soil = seedToSoilMap.dest(for: seed)
            let fertilizer = soilToFertilizerMap.dest(for: soil)
            let water = fertilizerToWaterMap.dest(for: fertilizer)
            let light = waterToLightMap.dest(for: water)
            let temperature = lightToTemperatureMap.dest(for: light)
            let humidity = temperatureToHumidityMap.dest(for: temperature)
            let location = humidityToLocationMap.dest(for: humidity)
            return location
        }

        let part1Seeds = seedNumbers
        let part1 = part1Seeds.map(findLocation(for:)).min()!
        print("Part 1: The lowest location number is \(part1)")

        let part2Seeds = seedNumbers.chunks(ofCount: 2).map(Array.init).map({ $0[0]..<($0[0] + $0[1]) }).map({ $0.striding(by: 1) })
        let part2 = await part2Seeds.concurrentMap { seedCollection in
            await Task {
                seedCollection.map(findLocation(for:)).min()!
            }.value
        }.min()!
        print("Part 2: The lowest location number is \(part2)")

        return ("\(part1)", "\(part2)")
    }

}
