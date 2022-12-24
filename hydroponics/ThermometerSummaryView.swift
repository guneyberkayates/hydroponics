//
//  ThermometerSummaryView.swift
//  hydroponics
//
//  Created by Güney Berkay  on 23.12.2022.
//

import SwiftUI

struct ThermometerSummaryView: View {
    var status: Status
    var showStatus: Bool
    var temperature : CGFloat
    
    var body: some View {
        VStack(spacing: 0){
            //temperature status
            Text(status.rawValue)
                .font(.headline)
                .foregroundColor(.white)
                .opacity(showStatus ? 0.6 : 0)
                .animation(.easeIn(duration: 0.5), value: showStatus)
            //temperature
            Text("\(temperature, specifier: "%.1f")")
                .font(.system(size: 54))
                .foregroundColor(.white)
            
            //eco lead
            
            Image(systemName: "leaf.fill")
                .font(.title2.bold())
                .foregroundColor(.green)
                
            
        }
        .padding(.top,40)
    }
}

struct ThermometerSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        ThermometerSummaryView(status: .heating, showStatus: true, temperature: 22)
            .background(Color("Inner Dial 2"))
    }
}
