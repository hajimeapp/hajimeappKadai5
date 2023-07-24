//
//  ContentView.swift
//  Kadai5
//
//  Created by Hajime on 7/19/23.
//

import SwiftUI

struct ContentView: View {
    
    @State var displayleftNumber = ""
    @State var displayrightNumber = ""
    @State var resultNumber = 0.0
    @State var showAlert = false
    @State var alertMessage = ""
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    TextFieldView(displayNumber: $displayleftNumber)
                    Text("÷")
                    TextFieldView(displayNumber: $displayrightNumber)
                }
                Button(action: {
                    validateWhetherItCanBeCalculated()
                }, label: {
                    Text("計算")
                })
                //アラートアクションの一つ( "OK" など)をタップするとisPresentedには自動的にfalseが代入される。そのため、タップ後にfalseを代入する処理は不要。
                .alert(isPresented: $showAlert, content: {
                    //dismissButton: .default(Text("OK"))を書かない場合はデフォルトで"OK"アクションが提供される
                    Alert(title: Text("課題5"), message: Text(alertMessage))
                })
            }
            .padding(.trailing, 100)
            HStack {
                Text(String(resultNumber))
                Spacer()
            }
            .padding(10)
            Spacer()
        }
    }
    
    func validateWhetherItCanBeCalculated() {
        if !validateInput(displayNumber: displayleftNumber) && !validateInput(displayNumber: displayrightNumber) {
            showAlert = true
            alertMessage = "数字を入力してください"
            displayleftNumber = ""
            displayrightNumber = ""
            resultNumber = 0.0
        } else if !validateInput(displayNumber: displayleftNumber) {
            showAlert = true
            alertMessage = "割られる数に数字を入力してください"
            displayleftNumber = ""
            resultNumber = 0.0
        } else if !validateInput(displayNumber: displayrightNumber) {
            showAlert = true
            alertMessage = "割る数に数字を入力してください"
            displayrightNumber = ""
            resultNumber = 0.0
        } else if displayrightNumber == "" {
            showAlert = true
            alertMessage = "割る数を入力して下さい"
            resultNumber = 0.0
        } else if displayrightNumber == "0" {
            showAlert = true
            alertMessage = "割る数には0を入力しないで下さい"
            displayrightNumber = ""
            resultNumber = 0.0
        } else if displayleftNumber == "" {
            showAlert = true
            alertMessage = "割られる数を入力して下さい"
            resultNumber = 0.0
        } else {
            calculate()
        }
    }
    
    func calculate() {
        let leftNumber = Double(displayleftNumber)!
        let rightNumber = Double(displayrightNumber)!
        resultNumber = leftNumber / rightNumber
    }
    
    func validateInput(displayNumber: String) -> Bool {
        if let _ = Double(displayNumber) {
            return true
        } else {
            return false
        }
    }
    
}

struct TextFieldView: View {
    @Binding var displayNumber: String
    var body: some View {
        TextField("", text: $displayNumber)
            .keyboardType(.numberPad)
            .textFieldStyle(.roundedBorder)
            .padding(15)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
