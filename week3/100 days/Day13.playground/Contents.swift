import Cocoa

var greeting = "Hello, playground"
protocol Vehicle {
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}
