//
//  MessageRoshamboView.swift
//
//
//  Created by Vito Royeca on 6/26/24.
//

import SwiftUI

public struct  MessageRoshamboView: View {
    var roshambo: String
    var showAnimation: Bool
    var font: Font

    @State private var animatedText = ""

    public init(roshambo: String,
                showAnimation: Bool,
                font: Font = Font.system(.largeTitle)) {
        if let last = roshambo.components(separatedBy: " ").last {
            self.roshambo = last
        } else {
            self.roshambo = roshambo
        }
        self.showAnimation = showAnimation
        self.font = font
    }

    public var body: some View {
        Text(animatedText)
            .font(font)
            .onAppear {
                if showAnimation {
                    animate()
                } else {
                    animatedText = roshambo
                }
            }
    }
    
    func animate() {
        let array = Roshambo.shared.values()
        var index = 0
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
        
            if index >= array.count {
                animatedText = roshambo
                timer.invalidate()
            } else {
                animatedText = array[index]
            }
            index += 1
        }
    }
}

struct  MessageRoshamboTestView: View {
    @State private var roshambo = Roshambo.shared.generate()
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
            MessageRoshamboView(roshambo: roshambo,
                                showAnimation: true)
            Button {
                isAnimating = true
                roshambo = Roshambo.shared.generate()
            } label: {
                Text("Generate\(isAnimating ? "..." : "")")
            }
        }
    }
}

#Preview {
    MessageRoshamboTestView()
}
