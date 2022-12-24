//
//  ThermometerScaleView.swift
//  hydroponics
//
//  Created by Güney Berkay  on 23.12.2022.
//

import SwiftUI

struct ThermometerScaleView: View {
    private var scaleSize: CGFloat = 276
    private var horizontalPadding: CGFloat = 20
    private var verticalPadding: CGFloat = 25
    
    var body: some View {
        ZStack{
            //scale lines
            ForEach(0..<21){
                line in
                scaleLine(at: line)
                
            }
            .frame(width: scaleSize, height: scaleSize)
            
            //temperature ring
            ZStack{
                HStack{
                    Text("10˚")
                    Spacer()
                    Text("30˚")
                }
                VStack{
                    Text("20˚")
                    Spacer()
                }
            }
            .frame(width: 390 - 2 * horizontalPadding, height: 390 - 2 * verticalPadding)
            .font(.subheadline)
            .foregroundColor(.white.opacity(0.3))
        }
    }
    func scaleLine(at line: Int) -> some View{
        VStack{
        Rectangle()
            .fill(Color("Scale Line"))
            .frame(width:2,height:10)
            
            Spacer()
        
        }
        .rotationEffect(.degrees(Double(line) * 9-90))
    }
}

struct ThermometerScaleView_Previews: PreviewProvider {
    static var previews: some View {
        ThermometerScaleView()
            .frame(maxWidth:.infinity,maxHeight: .infinity)
            .background(Color("Background"))
    }
}
