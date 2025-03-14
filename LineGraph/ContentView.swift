import SwiftUI

struct TeamPerformance: Identifiable {
    let id = UUID()
    let name: String
    let performance: Double
}

struct ContentView: View {
    let teams: [TeamPerformance] = [
        TeamPerformance(name: "1", performance: 7.0),
        TeamPerformance(name: "2", performance: 7.9),
        TeamPerformance(name: "3", performance: 7.8),
        TeamPerformance(name: "4", performance: 7.7),
        TeamPerformance(name: "5", performance: 7.2),
        TeamPerformance(name: "6", performance: 7.9),
        TeamPerformance(name: "7", performance: 7.9),
        TeamPerformance(name: "8", performance: 8.0),
        TeamPerformance(name: "9", performance: 8.9),
        TeamPerformance(name: "10", performance: 7.7)
    ]

    var body: some View {
        VStack(spacing: 10) {
            Text("Team Performance")
                .font(.title)
                .padding(.bottom, 10)

            LineGraph(data: teams.map { $0.performance })
                .frame(height: 30)
                .padding(.bottom, 10)

            HStack {
                ForEach(teams) { team in
                    Text(team.name)
                        .font(.caption)
                        .frame(width: 30)
                }
            }
        }
        .padding(.horizontal)
    }
}

struct LineGraph: View {
    let data: [Double]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                Path { path in
                    let width = geometry.size.width
                    let height = geometry.size.height
                    let stepX = width / CGFloat(data.count - 1)
                    
                    
                    let minValue = data.min() ?? 0
                    let maxValue = data.max() ?? 1
                    let range = maxValue - minValue
                    
                   
                    path.move(to: CGPoint(x: 0, y: height))
                    
                    for (index, value) in data.enumerated() {
                        let x = CGFloat(index) * stepX
                        let normalizedY = (value - minValue) / range
                        let y = height * (1 - CGFloat(normalizedY))
                        
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

                
                Path { path in
                    let width = geometry.size.width
                    let height = geometry.size.height
                    let stepX = width / CGFloat(data.count - 1)
                    let minValue = data.min() ?? 0
                    let maxValue = data.max() ?? 1
                    let range = maxValue - minValue
                    
                    for (index, value) in data.enumerated() {
                        let x = CGFloat(index) * stepX
                        let normalizedY = (value - minValue) / range
                        let y = height * (1 - CGFloat(normalizedY)) 
                        
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
