protocol Packet {
    var version: Int { get }
    var length: Int { get }
    var versionsSum: Int { get }
    var value: Int { get }
}

private struct LiteralPacket: Packet {
    let version: Int
    let literal: Int
    let length: Int
    var versionsSum: Int { self.version }
    var value: Int { self.literal }
}

private struct OperationPacket: Packet {
    enum Operation: Int {
        case sum = 0
        case product = 1
        case minimum = 2
        case maximum = 3
        case greaterThan = 5
        case lessThan = 6
        case equalTo = 7
    }

    let version: Int
    let operation: Operation
    let lengthTypeID: Character
    let subPackets: [Packet]
    var length: Int {
        // version + operation + length type ID + subpackages
        return 3 + 3 + 1 + (lengthTypeID == "0" ? 15 : 11) + subPackets.map(\.length).sum
    }
    var versionsSum: Int {
        self.version + subPackets.map(\.versionsSum).sum
    }
    var value: Int {
        switch self.operation {
            case .sum: return self.subPackets.map(\.value).sum
            case .product: return self.subPackets.map(\.value).product
            case .minimum: return self.subPackets.map(\.value).reduce(Int.max, min)
            case .maximum: return self.subPackets.map(\.value).reduce(Int.min, max)
            case .greaterThan: return self.subPackets[0].value > self.subPackets[1].value ? 1 : 0
            case .lessThan: return self.subPackets[0].value < self.subPackets[1].value ? 1 : 0
            case .equalTo: return self.subPackets[0].value == self.subPackets[1].value ? 1 : 0
        }
    }
}

private enum Parser {
    static func parse(from i: inout String.Iterator) -> Packet {
        let version = Int(i.next(3), radix: 2)!
        let typeID = Int(i.next(3), radix: 2)!

        switch typeID {
            case 4:
                let (literal, length) = self.parseLiteral(from: &i)
                return LiteralPacket(version: version, literal: literal, length: 3 + 3 + length)
            case let operation:
                let (subPackets, lengthTypeID) = self.parseSubPackets(from: &i)
                return OperationPacket(version: version,
                                       operation: OperationPacket.Operation(rawValue: operation)!,
                                       lengthTypeID: lengthTypeID,
                                       subPackets: subPackets)
        }
    }

    static private func parseLiteral(from i: inout String.Iterator) -> (Int, Int) {
        var binaryString = ""
        var length = 0
        while true {
            let nextGroup = i.next(5)
            binaryString += nextGroup.suffix(4)
            length += 5
            if nextGroup.first == "0" { break }
        }
        return (Int(binaryString, radix: 2)!, length)
    }

    static private func parseSubPackets(from i: inout String.Iterator) -> ([Packet], Character) {
        let lengthTypeID = i.next()!
        switch lengthTypeID {
            case "0":
                let numBits = Int(i.next(15), radix: 2)!
                var subPackets = [Packet]()
                while subPackets.map(\.length).sum < numBits {
                    subPackets.append(self.parse(from: &i))
                }
                return (subPackets, lengthTypeID)
            case "1":
                let numPackets = Int(i.next(11), radix: 2)!
                var subPackets = [Packet]()
                for _ in 1...numPackets {
                    subPackets.append(self.parse(from: &i))
                }
                return (subPackets, lengthTypeID)
            default: fatalError()
        }
    }
}



extension Challenges2021 {

    @discardableResult static func runDay16(input: Input) async throws -> ChallengeResult {
        let hexInput = input.lines().first!
        let bitInput = hexInput.map({ String(Int(String($0), radix: 16)!, radix: 2).padded(toSize: 4) }).joined()

        var iterator = bitInput.makeIterator()
        let packet = Parser.parse(from: &iterator)
        let versionSum = packet.versionsSum
        let value = packet.value

        print("Part 1: The sum of all packet versions is \(versionSum).")
        print("Part 2: The value of the top-level packet is \(value).")

        return (part1: "\(versionSum)", part2: "\(value)")
    }

}


private extension String.Iterator {

    mutating func next(_ count: Int) -> String {
        var chars = [Character]()
        while chars.count < count, let next = self.next() {
            chars.append(next)
        }
        return String(chars)
    }

}

private extension String {

    func padded(toSize: Int) -> String {
        var padded = self
        for _ in 0..<(toSize - self.count) {
            padded = "0" + padded
        }
        return padded
    }

}
