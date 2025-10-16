//
//  ContentView.swift
//  WeSplit
//
//  Created by Debora Kurdzhieva on 10/28/24.
//  Edited on 10/16/25.

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 4
    @State private var tipPercentage = 20
    @State private var customTip = ""
    
    let tipPercentages = [10, 15, 20, 25, 30]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let orderAmount = Double(checkAmount) ?? 0
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalWithTip: Double {
        let orderAmount = Double(checkAmount) ?? 0
        let tipSelection = Double(tipPercentage)
        let tipValue = orderAmount / 100 * tipSelection
        return orderAmount + tipValue
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("CHECK AMOUNT")) {
                    HStack {
                        Text("$")
                            .font(.title2)
                            .foregroundColor(.secondary)
                        TextField("Amount", text: $checkAmount)
                            .keyboardType(.decimalPad)
                            .font(.title2)
                            .bold()
                    }
                }
                
                Section(header: Text("Number of people")) {
                    Stepper(value: $numberOfPeople, in: 2...20) {
                        Text("\(numberOfPeople + 2) people")
                    }
                }
                
                Section(header: Text("HOW MUCH DO YOU WANT TO TIP?")) {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 5), spacing: 10) {
                        ForEach(tipPercentages, id: \.self) { percentage in
                            Button(action: {
                                tipPercentage = percentage
                                customTip = ""
                            }) {
                                Text("\(percentage)%")
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .background(tipPercentage == percentage ? Color.blue : Color.gray.opacity(0.2))
                                    .foregroundColor(tipPercentage == percentage ? .white : .primary)
                                    .cornerRadius(8)
                            }
                        }
                    }
                    .padding(.vertical, 5)
                    
                    HStack {
                        TextField("Enter custom tip (%)", text: $customTip)
                            .keyboardType(.numberPad)
                            .onChange(of: customTip) { newValue in
                                if let customTipValue = Int(newValue) {
                                    tipPercentage = customTipValue
                                }
                            }
                        if !customTip.isEmpty {
                            Text("%")
                        }
                    }
                }
                
                Section(header: Text("AMOUNT PER PERSON")) {
                    HStack {
                        Text("$")
                            .font(.title2)
                        Text("\(totalPerPerson, specifier: "%.2f")")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.blue)
                    }
                }
                
                Section(header: Text("TOTAL SUM INCLUDING TIP")) {
                    HStack {
                        Text("$")
                            .font(.title2)
                        Text("\(totalWithTip, specifier: "%.2f")")
                            .font(.title2)
                            .bold()
                    }
                    .foregroundColor(.green)
                }
            }
            .navigationTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
