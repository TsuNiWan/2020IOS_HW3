//
//  ContentView.swift
//  DataBinding
//
//  Created by 林子平 on 2020/4/29.
//  Copyright © 2020 林子平. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var showSecondPage = false
    @State private var showAlert = false
    
    @State private var name = ""
    @State private var birthDate = Date()
    @State private var exp = false
    @State private var expAmount = 1
    @State private var selectCar = "Lexus"
    
    let cars = ["Toyota", "Honda", "Nissan", "Ford", "BMW", "Lexus", "Benz", "Audi", "Porsche", "Lamborghini", "Ferrari"]
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("找出你的夢幻車輛")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                Spacer()
            }
            .padding()
            Button(action: {
                self.showAlert = true
            }) {
                Image("Question")
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250)
            }.alert(isPresented: $showAlert) { () -> Alert in
                return Alert(title: Text("希望能讓你找出你的夢幻車輛！！！"))
            }
            
            Form {
                TextField("你的名子", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                DatePicker("生日：", selection: $birthDate, in: ...Date(), displayedComponents: .date)
                
                DrivingExp(exp: $exp, expAmount: $expAmount)
                
                VStack(alignment: .leading) {
                    Text("我喜歡的車廠是")
                    Picker("喜歡的車廠", selection: $selectCar) {
                        ForEach(cars, id: \.self) { (car) in
                            Text(car)
                        }
                    }
                    .padding()
                    .labelsHidden()
                    .pickerStyle(WheelPickerStyle())
                }
                
            }
            .frame(width:400, height: 400)
            .clipped()
            
            Spacer()
            
            Button("顯示我的夢幻車輛") {
                self.showSecondPage = true
            }
            .sheet(isPresented: self.$showSecondPage) {
                SecondView(showSecondPage: self.$showSecondPage, name: self.$name, car: self.$selectCar)
            }
            .font(.headline)
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.blue, lineWidth: 5))
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct DrivingExp: View {
    @Binding var exp:Bool
    @Binding var expAmount:Int
    
    var body: some View {
        VStack {
            Toggle("你有開車經驗嗎", isOn: $exp)
            
            if exp {
                Stepper(value: $expAmount, in: 1...99, step: 1) {
                    Text("開車經歷：\(expAmount) 年")
                }
            }
        }
    }
}
