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
    
    @State private var x: [Int] = [1,3,5,7]
    @State private var y: [Int] = [2,4,6,8]
    
    @State private var xy: [Int] = []
    @State private var xSquared: [Int] = []
    @State private var ySquared: [Int] = []
    
    var body: some View {
        NavigationView {
            VStack {
                
                Text("Placeholder Instructions")
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
                
                Button("Calculate") {}
                    .disabled(x.isEmpty || y.isEmpty ? true : false)
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
                    Text("Result Info:")
                        .padding()
                    Text("Here are the results")
                    
                }
                
            }
            .navigationBarTitle("Pearson Correlation")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {}) {
                Image(systemName: "info.circle")
            })
        }
    }
    
    func removeXItems(at offsets: IndexSet) {
        x.remove(atOffsets: offsets)
    }
    func removeYItems(at offsets: IndexSet) {
        y.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
