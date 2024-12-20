import SwiftUI
import Charts

struct SparklineChartView: View {
    var sparkline: [Double]
    var percentageChange: Int
    
    var body: some View {
        VStack {
            Chart {
                ForEach(0..<sparkline.count, id: \.self) { index in
                    LineMark(
                        x: .value("Day", index),
                        y: .value("Price", sparkline[index])
                    )
                    .foregroundStyle(percentageChange < 0 ? Color.red : Color.green)
                    .lineStyle(StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                }
            }
            .chartYAxis(.hidden)
            // Dynamically set Y-axis range otherwise it will start at zero
            .chartYScale(domain: (sparkline.min() ?? 0)...(sparkline.max() ?? 1))
            .chartXAxis(.hidden)
            .frame(height: 35)
        }
    }
}

