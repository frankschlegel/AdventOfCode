
extension Sequence where Element == Int {

    var sum: Int {
        self.reduce(0, +)
    }

    var product: Int {
        self.reduce(1, *)
    }

}
