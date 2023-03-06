
import SwiftUI

struct CalculatorButtonModel: Identifiable {
    let id = UUID()
    let calculatorButton: CalculatorButton
    var color: Color = foregroundDigitsColor
}

struct RowOfCalculatorButtonModel: Identifiable {
    let id = UUID()
    let row: [CalculatorButtonModel]
}

struct CalculatorButtonsView: View {
    @Binding var mainResult: String
    @Binding var currentComputation: String
    
    let buttonData:     [RowOfCalculatorButtonModel] = [
        RowOfCalculatorButtonModel(row: [
            CalculatorButtonModel( calculatorButton: .clear, color: foregroundButtonTopColor),
            CalculatorButtonModel( calculatorButton: .negative, color: foregroundButtonTopColor),
            CalculatorButtonModel( calculatorButton: .percent, color: foregroundButtonTopColor),
            CalculatorButtonModel( calculatorButton: .divide, color: foregroundButtonRightCOlor)
        ]),
        RowOfCalculatorButtonModel(row: [
            CalculatorButtonModel( calculatorButton: .seven),
            CalculatorButtonModel( calculatorButton: .eight),
            CalculatorButtonModel( calculatorButton: .nine),
            CalculatorButtonModel( calculatorButton: .multiply, color: foregroundButtonRightCOlor)
        ]),
        RowOfCalculatorButtonModel(row: [
            CalculatorButtonModel( calculatorButton: .four),
            CalculatorButtonModel( calculatorButton: .five),
            CalculatorButtonModel( calculatorButton: .six),
            CalculatorButtonModel( calculatorButton: .substract , color: foregroundButtonRightCOlor)
        ]),
        RowOfCalculatorButtonModel(row: [
            CalculatorButtonModel( calculatorButton: .one),
            CalculatorButtonModel( calculatorButton: .two),
            CalculatorButtonModel( calculatorButton: .three),
            CalculatorButtonModel( calculatorButton: .add, color: foregroundButtonRightCOlor)
        ]),
        RowOfCalculatorButtonModel(row: [
            CalculatorButtonModel( calculatorButton: .undo),
            CalculatorButtonModel( calculatorButton: .zero),
            CalculatorButtonModel( calculatorButton: .decimal),
            CalculatorButtonModel( calculatorButton: .equal, color: foregroundButtonRightCOlor)
        ])
    ]
    
    var body: some View {
        Grid {
            ForEach(buttonData) {rowOfButtons in
                GridRow {
                    ForEach(rowOfButtons.row) {buttonItem in
                        Button(action: {
                            buttonPressed(button: buttonItem.calculatorButton)
                        }, label: {
                            ButtonView(calculatorButton: buttonItem.calculatorButton, fgColor: buttonItem.color, bgColor: backgroundButtonColor)
                        })
                    }
                }
            }
        }
        .padding()
    }
    
    func buttonPressed(button: CalculatorButton) {
        switch button {
        case .clear:
            currentComputation = ""
            mainResult = "0"
            
        case .equal, .negative:
            if !currentComputation.isEmpty {
                if !lastCharIsOperator(str: currentComputation) {
                    let sign = button == .negative ? -1.0 : 1.0
                    mainResult = formatResult(value: sign * calculateResults())
                    
                    if button == .negative {
                        currentComputation = mainResult
                    }
                }
            }
        case .decimal:
            if let lastOccurenceOfDecimalPoint = currentComputation.lastIndex(of: ".") {
                // 123.37 OR 123.6 + 102
                let startIndex = currentComputation.index(lastOccurenceOfDecimalPoint, offsetBy: 1)
                let endIndex = currentComputation.endIndex
                
                // substring -> 37 OR 6+102
                let rightSubString = String(currentComputation[startIndex..<endIndex])
                
                // did not find a Int,e.g,37, found instead 6+102, it is valid to append "."
                if Int(rightSubString) == nil && !rightSubString.isEmpty {
                    currentComputation += "."
                }
            } else {
                if currentComputation.isEmpty {
                    currentComputation += "0."
                } else if lastCharIsDigit(str: currentComputation) {
                    currentComputation += "."
                }
            }
        case .percent:
            if lastCharIsDigit(str: currentComputation) {
                appendToCurrentComputation(button: button)
            }
        case .undo:
            currentComputation = String(currentComputation.dropLast())
        case .add, .substract, .divide, .multiply:
            if lastCharIsDigitOrPercent(str: currentComputation) {
               appendToCurrentComputation(button: button)
            }
        default:
            appendToCurrentComputation(button: button)
        }
    }
    
    func appendToCurrentComputation(button: CalculatorButton) {
        currentComputation += button.rawValue
    }
    
    func calculateResults() -> Double {
        let visibleComputation: String =    currentComputation
        var computations = visibleComputation.replacingOccurrences(of: "%", with: "*0.01")
        computations = computations.replacingOccurrences(of: multiplySymbol, with: "*")
        computations = computations.replacingOccurrences(of: divideSymbol, with: "/")
        
        if getLastChar(str: computations) == "." {
            computations += "0"
        }
        
        // key point, actual computation
        let expr =  NSExpression(format: computations)
        let exprValue = expr.expressionValue(with: nil, context: nil) as! Double
        return exprValue
    }
}

struct CalculatorButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButtonsView(mainResult: .constant("6"), currentComputation: .constant("4+2"))
    }
}
