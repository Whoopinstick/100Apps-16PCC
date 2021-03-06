//
//  ContentView.swift
//  16 - Pearson Correlation Coefficients
//
//  Created by Kevin Paul on 9/5/20.
//  Copyright © 2020 Whoopinstick. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var xText = ""
    @State private var yText = ""
    
    @State private var x: [Int] = [43,21,25,42,57,59]
    @State private var y: [Int] = [99,65,79,75,87,81]
    
    @State private var xy: [Int] = []
    @State private var xSquared: [Int] = []
    @State private var ySquared: [Int] = []
    
    @State private var xSum: Double = 0.0
    @State private var ySum: Double = 0.0
    @State private var xySum: Double = 0.0
    @State private var xSquaredSum: Double = 0.0
    @State private var ySquaredSum: Double = 0.0
    
    @State private var result: Double = 0.0
    
    @State private var resultsVisible = false
    
    var body: some View {
        NavigationView {
            VStack {
                
                Text("Add/remove an equal number of values for both X and Y and click Calculate")
                    .padding()
                
                HStack {
                    TextField("Enter X value", text: $xText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .padding()
                    
                    Spacer()
                    
                    TextField("Enter Y value", text: $yText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .padding()
                }
                
                HStack {
                    Button("Add X Value") {
                        self.x.append(Int(self.xText) ?? 0)
                        self.xText = ""
                    }
                        .padding(.horizontal)
                        .disabled(xText.isEmpty ? true : false)
                    
                    Spacer()
                    
                    Button("Add Y Value") {
                        self.y.append(Int(self.yText) ?? 0)
                        self.yText = ""
                    }
                        .padding(.horizontal)
                        .disabled(yText.isEmpty ? true : false)
                }
                
                Button("Calculate") {
                    self.resultsVisible = true
                    self.calculate()
                }
                .disabled(x.isEmpty || y.isEmpty || x.count != y.count ? true : false)
                    .padding()
                
                Spacer()
                
                HStack {
                    List {
                        ForEach(x, id: \.self) { value in
                            Text("\(value)")
                        }
                        .onDelete(perform: removeXItems)
                    }
                    
                    Spacer()
                    
                    List {
                        ForEach(y, id: \.self) { value in
                            Text("\(value)")
                        }
                        .onDelete(perform: removeYItems)
                    }
                }
                .padding()
                
                Spacer()
                
                VStack {
                    Text("Result:")
                        .padding()
                    Text("r = \(result)")
                    
                }
                .opacity(resultsVisible ? 1.0 : 0.0)
                
            }
            .navigationBarTitle("Pearson Correlation")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                self.x = []
                self.y = []
                self.xy = []
                self.xSquared = []
                self.ySquared = []
                self.xSum = 0.0
                self.ySum = 0.0
                self.xySum = 0.0
                self.xSquaredSum = 0.0
                self.ySquaredSum = 0.0
                self.result = 0.0
                self.resultsVisible = false
            }) {
                Image(systemName: "xmark.square")
            })
        }
    }
    
    func removeXItems(at offsets: IndexSet) {
        x.remove(atOffsets: offsets)
    }
    func removeYItems(at offsets: IndexSet) {
        y.remove(atOffsets: offsets)
    }
    
    func calculate() {
        for i in 0..<x.count {
            xy.append(x[i] * y[i])
            xSquared.append(x[i] * x[i])
            ySquared.append(y[i] * y[i])
        }
        
        for i in 0..<x.count {
            xSum += Double(x[i])
            ySum += Double(y[i])
            xySum += Double(xy[i])
            xSquaredSum += Double(xSquared[i])
            ySquaredSum += Double(ySquared[i])
        }
        
        //formula example from https://www.statisticshowto.com/probability-and-statistics/correlation-coefficient-formula/
        let count: Double = Double(x.count)
        let numerator = (count * xySum) - (xSum * ySum)
        let denominator = ((count * xSquaredSum) - (xSum * xSum)) * ((count * ySquaredSum) - (ySum * ySum))
        
        result = numerator / denominator.squareRoot()
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
