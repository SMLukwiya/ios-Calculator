
import Foundation

enum Operation {
    case add, substact, multiply, divide, equal, none
}

enum CalculatorButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case substract = "-"
    case divide = "÷"
    case multiply = "×"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "IMGplus.forwardslash.minus"
    case undo = "IMGarrow.counterclockwise"
}

let enumOperators: [CalculatorButton] = [.add, .substract, .divide, .multiply]

let multiplySymbol: String = CalculatorButton.multiply.rawValue
let divideSymbol: String = CalculatorButton.divide.rawValue

let operators = "+-\(multiplySymbol)\(divideSymbol)"  
