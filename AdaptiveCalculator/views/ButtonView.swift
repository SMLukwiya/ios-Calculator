        
import SwiftUI

struct ButtonView: View {
                        let calculatorButton: CalculatorButton
                        let fgColor: Color
                        let bgColor: Color
                        
                        var systemImage: String? {
                            let value = calculatorButton.rawValue
                            return value.contains("IMG") ? value.replacingOccurrences(of: "IMG", with: "") : nil
                        }
                        
                        var text: String? {
                            let value =     calculatorButton.rawValue
                            return value.contains("IMG") ? nil : value
                        }
                        let buttonDim: CGFloat = UIScreen.main.bounds.width / 5
                        
                        var body: some View {
                            ZStack {
                                // show one or the other
                                Text(text ?? "")
                                Image(systemName: systemImage ?? "")
                            }
                            .font(.title2)
                            .fontWeight(.semibold)
                            .frame(width: buttonDim, height: buttonDim)
                            .foregroundColor(fgColor)
                            .background(bgColor)
                            .cornerRadius(15)
    }               
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(calculatorButton: .one, fgColor: foregroundDigitsColor, bgColor: backgroundButtonColor)
    }
}
