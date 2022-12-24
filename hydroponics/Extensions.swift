//
//  Extensions.swift
//  hydroponics
//
//  Created by Güney Berkay  on 23.12.2022.
//


import SwiftUI

extension LinearGradient{
    init(_ colors:[Color], startPoint: UnitPoint = .topLeading, endPoint: UnitPoint = .bottomTrailing){
        self.init(gradient:Gradient(colors: colors),startPoint:startPoint,endPoint: endPoint)
    }
}
