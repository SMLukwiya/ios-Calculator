
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
            print("eq/ng")
            if !currentComputation.isEmpty {
                if lastCharIsOperator(str: currentComputation) {
                    let sign = button == .negative ? -1.0 : 1.0
                    mainResult = formatResult(value: sign * calculateResults())
                    
                    if button == .negative {
                        currentComputation = mainResult
                    }
                }
            }
        case .decimal:
            print("dec")
        case .percent:
            print("%")
        case .undo:
            print("undo")
            currentComputation = String(currentComputation.dropLast())
        case .add, .substract, .divide, .multiply:
            print("ops")
            if lastCharIsDigit(str: currentComputation) {
               appendToCurrentComputation(button: button)
            }
        default:
            print("default")
            appendToCurrentComputation(button: button)
        }
    }
    
    func appendToCurrentComputation(button: CalculatorButton) {
        currentComputation += button.rawValue
    }
    
    func calculateResults() -> Double {
        
    }
}

struct CalculatorButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorButtonsView(mainResult: .constant("6"), currentComputation: .constant("4+2"))
    }
}
