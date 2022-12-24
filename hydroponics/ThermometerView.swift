//
//  Thermometer.swift
//  hydroponics
//
//  Created by Güney Berkay  on 23.12.2022.
//

import SwiftUI

enum Status: String{
    case heating = "HEATING"
    case cooling = "COOLING"
    case reaching = "REACHING"
    
}

struct ThermometerView: View {
    private let ringSize: CGFloat = 220
    private let outerDialSize: CGFloat = 200
    private let minTemperature: CGFloat = 4
    private let maxTemperature: CGFloat = 30
    
    @State private var currentTemperature: CGFloat = 0
    @State private var degrees: CGFloat = 36
    @State private var showStatus = false
    @State private var x: CGFloat = 0
    @State private var y: CGFloat = 0
    @State private var angle: CGFloat = 0
    
    var targetTemperature : CGFloat{
        return min(max(degrees/360 * 40, minTemperature),maxTemperature)
        
    }
    
    var ringValue: CGFloat{
        return currentTemperature / 40
    }
    
    var status :Status {
        if currentTemperature < targetTemperature {
            return .heating
        }else if currentTemperature > targetTemperature {
            return .cooling
        }
        else {
            return .reaching
        }
    }
    let timer = Timer
        .publish(every: 1,on: .main, in: .common)
        .autoconnect()
    
    
    var body: some View {
        ZStack{
            ThermometerScaleView()
        
            
            //Placeholder
            ThermometerPlaceholderView()
            
            //temperature ring
            Circle()
                .inset(by: 0.5)
                .trim(from: 0.099, to: min(ringValue,0.75))
                .stroke(LinearGradient([Color("Temperature Ring 1"),Color("Temperature Ring 2")]),style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                .frame(width: ringSize, height: ringSize)
                .rotationEffect(.degrees(90))
                .animation(.linear(duration: 1), value: ringValue)
            
            //thermometer dial
            
            ThermometerDialView(degrees: degrees)
                .gesture(
                DragGesture()
                    .onChanged({value in
                        let x = min(max(value.location.x,0),outerDialSize)
                        let y = min(max(value.location.y,0),outerDialSize)
                        self.x = x
                        self.y = y
                        
                        let endPoint = CGPoint(x: x, y: y)
                        let centerPoint = CGPoint(x: outerDialSize / 2, y: outerDialSize / 2)
                        
                        let angle = calculateAngle(centerPoint: centerPoint, endpoint: endPoint)
                        self.angle = angle
                        if angle < 36 || angle > 270 {return}
                        
                        degrees = angle - angle.remainder(dividingBy: 18)
                    }))
            ThermometerSummaryView(status: status, showStatus: showStatus, temperature: currentTemperature)
            
            VStack{
                Text("x : \(x), y:\(y)")
                Text("angle : \(angle.formatted())")
                Text("degrees:\(degrees.formatted())")
                Spacer()
            }
            .foregroundColor(.white)
        }
        .onAppear{
            currentTemperature = 22
            degrees = currentTemperature / 40 * 360
        }
        .onReceive(timer){ _ in
            switch status{
            case .heating :
                showStatus = true
                currentTemperature += 0.5
            case .cooling:
                showStatus = true
                currentTemperature -= 0.5
            case .reaching:
                showStatus = false
                break
            }
            
        }
        .onDisappear{
            timer.upstream.connect().cancel()
        }
            
        }
    }


struct Thermometer_Previews: PreviewProvider {
    static var previews: some View {
        ThermometerView()
            .frame(maxWidth:.infinity,maxHeight: .infinity)
            .background(Color("Background"))
    }
}

extension ThermometerView {
    private func calculateAngle(centerPoint: CGPoint,endpoint : CGPoint)-> CGFloat{
        let radians = atan2(endpoint.x - centerPoint.x , centerPoint.y - endpoint.y)
        let degrees = radians * 180 / .pi
        
        return degrees
        
    }
}
