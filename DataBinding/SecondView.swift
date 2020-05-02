//
//  SecondView.swift
//  DataBinding
//
//  Created by 林子平 on 2020/5/3.
//  Copyright © 2020 林子平. All rights reserved.
//

import SwiftUI

struct SecondView: View {
    @Binding var showSecondPage: Bool
    @Binding var name:String
    @Binding var car:String
    @State private var brightnessAmount:Double = 0
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                Text("\(self.name)")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    + Text("的夢幻車是")
                        .font(.title)
                Spacer()
            }
            
            Image(car)
                .resizable()
                .scaledToFit()
                .brightness(self.brightnessAmount)
            
            HStack {
                Text("亮度")
                Slider(value: self.$brightnessAmount, in: 0...1,
                       minimumValueLabel: Image(systemName:
                        "sun.max.fill").imageScale(.small), maximumValueLabel:
                Image(systemName: "sun.max.fill").imageScale(.large)) {
                    Text("")
                }
            }
            .padding()
            
            Spacer()
        }
        .overlay(Button(action: {
            self.showSecondPage = false
        }){
            Image(systemName: "xmark.octagon.fill")
                .imageScale(.large)
                .padding()
        }, alignment: .topLeading)
        
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView(showSecondPage: .constant(true), name: .constant("kumo"), car: .constant("Toyota"))
        
    }
}
