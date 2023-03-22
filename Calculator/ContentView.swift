//
//  ContentView.swift
//  Calculator
//
//  Created by Tuan Le on 2023-03-15.
//

import SwiftUI
import AVFAudio


enum Operator {
    case none
    case add
    case subtract
    case multiply
    case divide
}

struct ContentView: View {
    @State private var accumulator = 0.0
    @State private var display = ""
    @State private var memory = 0.0
    @State private var pendingOperation: Operator = .none
    @State private var displayChange =  false
    @State private var aVAudioPlayer: AVAudioPlayer!
    @State private var showAlert = false
    
    func playSound(_ fileName: String) {
        let url = Bundle.main.url(forResource: fileName, withExtension: "mp3")
        aVAudioPlayer = try! AVAudioPlayer(contentsOf: url!)
        aVAudioPlayer.play()
    }
    
    func addDisplayText(_ digit: String) {
        playSound("dry-fart")
        if displayChange {
            display = digit
            displayChange = false
        } else {
            display += digit
        }
    }
    
    func doOperation(_ opr: Operator) {
        playSound("dry-fart")
        let val = Double(display) ?? 0.0;
    
        switch pendingOperation {
        case .none:
            accumulator = val
        case .add:
            accumulator += val
        case .subtract:
            accumulator -= val
        case .multiply:
            accumulator *= val
        case .divide:
            accumulator /= val
        }
        displayChange = true
        pendingOperation = opr
        display = "\(accumulator)"
    }
    
   
    var body: some View {
        GeometryReader{geometryReader in LazyVStack {
            Text(display).foregroundColor(.white).frame(width: geometryReader.size.width*0.9, height: geometryReader.size.height*0.1).background(Image("Screen").resizable().scaledToFill()).padding(.vertical, geometryReader.size.width*0.1)
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Button(action: {addDisplayText("7")}, label: {Image("7").resizable().scaledToFit()})
                    Button(action: {addDisplayText("8")}, label: {Image("8").resizable().scaledToFit()})
                    Button(action: {addDisplayText("9")}, label: {Image("9").resizable().scaledToFit()})
                }
                HStack(spacing: 0) {
                    Button(action: {addDisplayText("4")}, label: {Image("4").resizable().scaledToFit()})
                    Button(action: {addDisplayText("5")}, label: {Image("5").resizable().scaledToFit()})
                    Button(action: {addDisplayText("6")}, label: {Image("6").resizable().scaledToFit()})
                }
                HStack(spacing: 0) {
                    Button(action: {addDisplayText("1")}, label: {Image("1").resizable().scaledToFit()})
                    Button(action: {addDisplayText("2")}, label: {Image("2").resizable().scaledToFit()})
                    Button(action: {addDisplayText("3")}, label: {Image("3").resizable().scaledToFit()})
                }
                HStack(spacing: 0) {
                    Button(action: {
                        display = ""
                        accumulator = 0.0
                        memory = 0.0
                    }, label: {Image("C").resizable().scaledToFit()})
                    Button(action: {addDisplayText("0")}, label: {Image("0").resizable().scaledToFit()})
                    Button(action: {doOperation(.none)}, label: {Image("Equal").resizable().scaledToFit()})
                }
                HStack(spacing: 0) {
                    Button(action: {doOperation(.add)}, label: {Image("Add").resizable().scaledToFit()})
                    Button(action: {doOperation(.subtract)}, label: {Image("Subtract").resizable().scaledToFit()})
                    Button(action: {doOperation(.multiply)}, label: {Image("Multiply").resizable().scaledToFit()})
                    Button(action: {doOperation(.divide)}, label: {Image("Divide").resizable().scaledToFit()})
                    Button(action: {
                        playSound("quack_5")
                        showAlert = true
                    }, label: {Image(systemName: "moonphase.full.moon.inverse")}).alert(isPresented: $showAlert) {Alert(title: Text("Dear Mr. Mark,"), message: Text("Thank you for teaching Swift."))}.frame(width: geometryReader.size.width*0.9/5)
                }
            }.frame(width: geometryReader.size.width*0.9)
        }}.background(Image("Background").resizable().scaledToFill().edgesIgnoringSafeArea(.all))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
