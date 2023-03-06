
import Foundation

// Return last character if exists otherwise an empty string
func getLastChar(str: String) -> String {
    return str.isEmpty ? "" : String(str.last!)
}

func lastCharEqualTo(str: String, char: String) -> Bool {
    let lastStr = getLastChar(str: str)
    return lastStr == char
}

func formatResult(value: Double) -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.numberStyle = .decimal
    numberFormatter.maximumFractionDigits = 16
    let result = numberFormatter.string(from: NSNumber(value: value))
    
    return result ?? "0 "
}
