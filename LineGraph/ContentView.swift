//
//  ContentView.swift
//  LineGraph
//
//  Created by Yung Bros on 14/03/2025.
//

import SwiftUI

struct ContentView: View {
    let teams: [Double] = [
        7.0, 7.9, 7.8, 7.7, 7.2, 7.9, 7.9, 8.0, 8.9, 7.7
    ]

    var body: some View {
        VStack {
            Text("Another View")
                .font(.largeTitle)
                .padding()

            // Call the PerformanceGraphView
            PerformanceGraphView(data: teams)
                .padding()
        }
    }
}

#Preview {
    ContentView()
}

