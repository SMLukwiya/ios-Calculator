
import SwiftUI

struct MainCalculatorView: View {
    @State var currentComputation: String = ""
    @State var mainResult: String = "0"
    @State var lightMode: Bool = true
    
    var body: some View {
        ZStack {
            backgroundPrimaryColor.ignoresSafeArea()
            
            VStack {
                SunMoonView(lightMode: lightMode)
                    .onTapGesture {
                        withAnimation {
                            lightMode.toggle()
                        }
                    }
                Spacer()
                
                ComputationView(mainResult: mainResult, currentComputation: currentComputation)
                
                Spacer()
                
                CalculatorButtonsView(mainResult: $mainResult, currentComputation: $currentComputation)
                
            }
            .padding()
        }
        .environment(\.colorScheme, lightMode ? .light : .dark  )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainCalculatorView()
    }
}
