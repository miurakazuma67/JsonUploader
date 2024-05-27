//
//  ContentView.swift
//  SendJsonFileSample
//
//  Created by 三浦一真 on 2024/05/19.
//
import SwiftUI


struct ContentView: View {
    @State private var name: String = ""
    @State private var age: String = ""
    @State private var dataSaved = false

    var body: some View {
        VStack {
            TextField("名前", text: $name)
                .padding()
                .border(Color.gray)

            TextField("年齢", text: $age)
                .padding()
                .border(Color.gray)

            Button(action: {
                saveData(name: name, age: age)
            }) {
                Text("保存")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            if dataSaved {
                Text("データが保存されました")
                    .foregroundColor(.green)
                    .padding()
            }
        }
        .padding()
    }

    func saveData(name: String, age: String) {
        let userData = ["name": name, "age": age]
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: userData, options: []) {
            let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = directory.appendingPathComponent("userData.json")
            
            do {
                try jsonData.write(to: fileURL)
                dataSaved = true
            } catch {
                print("Failed to save data: \(error)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
