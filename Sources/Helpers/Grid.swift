import Algorithms


struct Grid<Element> {

    struct Point: Hashable {
        let x: Int, y: Int, value: Element

        static func == (lhs: Self, rhs: Self) -> Bool {
            return lhs.x == rhs.x && lhs.y == rhs.y
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(self.x)
            hasher.combine(self.y)
        }
    }

    var elements: [[Element]]

    let padding: Element?

    var width: Int {
        return self.elements.first?.count ?? 0
    }
    var height: Int {
        return self.elements.count
    }

    init(_ elements: [[Element]], padding: Element? = nil) {
        self.elements = elements
        self.padding = padding
    }

    subscript(_ x: Int, _ y: Int) -> Point? {
        guard self.elements.indices.contains(y), self.elements[0].indices.contains(x) else {
            return self.padding.map({ Point(x: x, y: y, value: $0) }) ?? nil
        }
        return Point(x: x, y: y, value: self.elements[y][x])
    }

    subscript(_ x: Int, _ y: Int) -> Element? {
        get { self[x, y]?.value }
        set { if let newValue = newValue { self.elements[y][x] = newValue } }
    }

    var allPoints: [Point] {
        product(0...self.width-1, 0...self.height-1).compactMap { self[$0.0, $0.1] }
    }
    var allValues: [Element] {
        self.allPoints.map(\.value)
    }

    var rows: [[Point]] {
        return self.elements.enumerated().map { y, row in
            row.enumerated().map { x, value in
                Point(x: x, y: y, value: value)
            }
        }
    }

    func getDirectNeighbors(_ x: Int, _ y: Int) -> Set<Point> {
        return Set<Point>([
            self[x-1, y],
            self[x, y-1],
            self[x+1, y],
            self[x, y+1],
        ].compacted())
    }

    func getDirectNeighbors(_ point: Point) -> Set<Point> {
        return self.getDirectNeighbors(point.x, point.y)
    }

    func getNeighbors(_ x: Int, _ y: Int, includeCenter: Bool = false) -> [Point] {
        var result = [Point?]()
        for currentY in y-1...y+1 {
            for currentX in x-1...x+1 {
                if !includeCenter, currentX == x, currentY == y { continue }
                result.append(self[currentX, currentY])
            }
        }
        return result.compactMap({ $0 })
    }

    func getNeighbors(_ point: Point, includeCenter: Bool = false) -> [Point] {
        return self.getNeighbors(point.x, point.y, includeCenter: includeCenter)
    }

    func padded(by padding: Int = 1) -> Self {
        guard let paddingElement = self.padding else { return self }

        let paddingPerRow = Array(repeating: paddingElement, count: padding)
        let paddingRow = Array(repeating: paddingElement, count: self.width + 2 * padding)
        let paddingRows = Array(repeating: paddingRow, count: padding)
        let paddedRows = self.elements.map({ paddingPerRow + $0 + paddingPerRow })
        let newElement = paddingRows + paddedRows + paddingRows
        return Grid(newElement, padding: self.padding)
    }

    func cropped(by amount: Int) -> Self {
        let croppedRange = amount...(self.width - 2 * amount)
        let croppedRows = self.elements.map({ Array($0[croppedRange]) })
        return Grid(Array(croppedRows[croppedRange]), padding: self.padding)
    }

    func withPadding(_ padding: Element) -> Self {
        return Grid(self.elements, padding: padding)
    }

    func map(_ block: (Point) -> Element) -> Self {
        let mappedElements = self.elements.enumerated().map { y, row in
            row.enumerated().map { x, value in
                return block(Point(x: x, y: y, value: value))
            }
        }
        return Grid(mappedElements, padding: self.padding)
    }

    func applyingConvolution(_ block: ([Point]) -> Element) -> Self {
        let padded = self.padded()
        return padded.map({ block(padded.getNeighbors($0, includeCenter: true)) })
    }

}

extension Grid: CustomStringConvertible where Element: CustomStringConvertible {

    var description: String {
        self.elements.map({ $0.map(\.description).joined() }).joined(separator: "\n")
    }

}
