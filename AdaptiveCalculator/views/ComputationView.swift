//
//  ComputationView.swift
//  AdaptiveCalculator
//
//  Created by m1 on 06/03/2023.
//

import SwiftUI

struct ComputationView: View {
    let mainResult: String
    let currentComputation: String
    
    var body: some View {
        VStack(spacing: 10  ) {
            HStack {
                Spacer()
                Text(currentComputation)
                    .foregroundColor(foregroundDigitsColor)
                    .font(UIDevice.isIpad ? .largeTitle : .body)
                    .lineLimit(1)
            }
            .minimumScaleFactor(0.1)
            HStack {
                Spacer()
                Text(mainResult)
                    .foregroundColor(foregroundDigitsColor)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .lineLimit(1)
            }
            .minimumScaleFactor(0.1 )
        }.padding(.horizontal)
    }
}

struct ComputationView_Previews: PreviewProvider {
    static var previews: some View {
        ComputationView(mainResult: "6", currentComputation: "4+2"  )
    }
}
