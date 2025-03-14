//
//  LineGraph.swift
//  LineGraph
//
//  Created by Yung Bros on 14/03/2025.
//

import SwiftUI

// Reusable LineGraph component
struct LineGraph: View {
    let data: [Double]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Gradient fill below the line
                Path { path in
                    let width = geometry.size.width
                    let height = geometry.size.height
                    let stepX = width / CGFloat(data.count - 1)
                    
                    // Normalize the data to the range of the graph
                    let minValue = data.min() ?? 0
                    let maxValue = data.max() ?? 1
                    let range = maxValue - minValue
                    
                    // Start at the bottom-left corner
                    path.move(to: CGPoint(x: 0, y: height))
                    
                    for (index, value) in data.enumerated() {
                        let x = CGFloat(index) * stepX
                        let normalizedY = (value - minValue) / range // Normalize to [0, 1]
                        let y = height * (1 - CGFloat(normalizedY)) // Scale to graph height
                        
                        if index == 0 {
                            path.addLine(to: CGPoint(x: x, y: y))
                        } else {
                            let previousX = CGFloat(index - 1) * stepX
                            let previousNormalizedY = (data[index - 1] - minValue) / range
                            let previousY = height * (1 - CGFloat(previousNormalizedY))
                            
                            let controlX1 = previousX + (x - previousX) / 2
                            let controlY1 = previousY
                            let controlX2 = controlX1
                            let controlY2 = y
                            
                            path.addCurve(to: CGPoint(x: x, y: y),
                                          control1: CGPoint(x: controlX1, y: controlY1),
                                          control2: CGPoint(x: controlX2, y: controlY2))
                        }
                    }
                    
                    // Close the path by adding a line to the bottom-right corner and back to the start
                    path.addLine(to: CGPoint(x: width, y: height))
                    path.addLine(to: CGPoint(x: 0, y: height))
                }
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.blue.opacity(0.05)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )

                // Line graph
                Path { path in
                    let width = geometry.size.width
                    let height = geometry.size.height
                    let stepX = width / CGFloat(data.count - 1)
                    
                    // Normalize the data to the range of the graph
                    let minValue = data.min() ?? 0
                    let maxValue = data.max() ?? 1
                    let range = maxValue - minValue
                    
                    for (index, value) in data.enumerated() {
                        let x = CGFloat(index) * stepX
                        let normalizedY = (value - minValue) / range // Normalize to [0, 1]
                        let y = height * (1 - CGFloat(normalizedY)) // Scale to graph height
                        
                        if index == 0 {
                            path.move(to: CGPoint(x: x, y: y))
                        } else {
                            let previousX = CGFloat(index - 1) * stepX
                            let previousNormalizedY = (data[index - 1] - minValue) / range
                            let previousY = height * (1 - CGFloat(previousNormalizedY))
                            
                            let controlX1 = previousX + (x - previousX) / 2
                            let controlY1 = previousY
                            let controlX2 = controlX1
                            let controlY2 = y
                            
                            path.addCurve(to: CGPoint(x: x, y: y),
                                          control1: CGPoint(x: controlX1, y: controlY1),
                                          control2: CGPoint(x: controlX2, y: controlY2))
                        }
                    }
                }
                .stroke(Color.blue, lineWidth: 1.5)
            }
        }
    }
}
