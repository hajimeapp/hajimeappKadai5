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
                    calculate()
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
    
    func calculate() {
        //エラーハンドリングする場合は、guard文でエラーとなる場合のみを記載していくとスリムに書ける
        guard let leftNumber = Double(displayleftNumber) else {
            showAlert = true
            alertMessage = "割られる数を入力して下さい"
            return
        }
        guard let rightNumber = Double(displayrightNumber) else {
            showAlert = true
            alertMessage = "割る数を入力して下さい"
            return
        }
        guard rightNumber != 0 else {
            showAlert = true
            alertMessage = "割る数には0を入力しないで下さい"
            return
        }
        // guard letの後ろに記載する定数は、同じスコープ内であれば利用できる（定数を宣言しているのと同じ）
        resultNumber = leftNumber / rightNumber
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
