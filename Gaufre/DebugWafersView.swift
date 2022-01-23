//
//  DebugProcessorObserver.swift
//  Gaufre
//
//  Created by MacBook Pro M1 on 2022/01/23.
//

import SwiftUI

#if DEBUG
struct DebugWafersView: View {
    var coreCount: Int
    
    var body: some View {
        HStack(alignment: .bottom) {
            ForEach(0..<coreCount) { _ in
                let coreUsage = Double.random(in: 0.0...99.9)
                
                BarView(value: coreUsage)
            }
        }
    }
}

struct BarView: View {
    var value: CGFloat
    var maxValue: CGFloat = 120
    var color = Color(.sRGB, red: 0.2, green: 0.5, blue: 0.8)
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 30, height: maxValue)
                    .foregroundColor(.secondary.opacity(0.2))
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 30, height: value)
                    .foregroundColor(color)
            }
        }
    }
}
#endif
