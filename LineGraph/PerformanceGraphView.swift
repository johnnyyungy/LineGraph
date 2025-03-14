//
//  PerformanceGraphView.swift
//  LineGraph
//
//  Created by Yung Bros on 14/03/2025.
//

import SwiftUI

struct PerformanceGraphView: View {
    let data: [Double]
    
    var body: some View {
        ZStack {
            // White container with 7% opacity
            Color.white.opacity(0.07)
                .cornerRadius(12) // Rounded corners
                .padding(.horizontal, 10) // 10-point margin on the left and right
                .frame(height: 224) // Set height to 224

            VStack(spacing: 10) {
                Text("Team Performance")
                    .font(.title)
                    .padding(.bottom, 10)

                LineGraph(data: data)
                    .frame(height: 30)
                    .padding(.bottom, 10)

                // Team names (optional)
                HStack {
                    ForEach(0..<data.count, id: \.self) { index in
                        Text("Team \(index + 1)")
                            .font(.caption)
                            .frame(width: 30)
                    }
                }
            }
            .padding(.horizontal, 20) // Add padding inside the container
        }
    }
}
