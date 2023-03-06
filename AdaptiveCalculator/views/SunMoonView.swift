//
//  SunMoonView.swift
//  AdaptiveCalculator
//
//  Created by m1 on 06/03/2023.
//

import SwiftUI

struct SunMoonView: View {
    let lightMode: Bool
    
    var body: some View {
        HStack(spacing: 30) {
            Image(systemName: "sun.min")
                .imageScale(.large)
                .foregroundColor(lightMode ? sunOrMoonSelectedColor : sunOrMoonNotSelectedColor )
            Image(systemName: "moon")
                .imageScale(.large)
                .foregroundColor(lightMode ? sunOrMoonNotSelectedColor : sunOrMoonSelectedColor)
        }
        .padding()
        .background(backgroundSecondaryColor)
        .cornerRadius(20)
    }
}

struct SunMoonView_Previews: PreviewProvider {
    static var previews: some View {
        SunMoonView(lightMode: true)
    }
}
