//
//  SharkCatWidgetView.swift
//  SharkCatTracker
//
//  Created by Teo on 12/18/24.
//

import SwiftUI

let smallFontSize: CGFloat = 9
let largerFontSize:CGFloat = 15

struct SharkCatWidgetView: View {
    var price: Double
      var marketCap: Double
      var percentageChange: Int  
      var imageUrl: String
      var sparkline: [Double]
      var theme: String
        
    var body: some View {
            VStack() {
                // Token Image
                HStack(spacing: 0) {
                    ZStack{
                        
                        //Fix here reading to memory as Uiimage instead of rendering the image instantly
                        if let uiImage = UIImage(named: "cat", in: Bundle.main, compatibleWith: nil) {
                           Image(uiImage: uiImage)
                               .resizable()
                               .frame(width: 50, height: 50)
                         }
                        
                    }
                    
                    VStack{
                        Text("SC / USD")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                            .fontWeight(.semibold)
                        Text("$\(String(format: "%.4f", price))")
                            .font(.system(size: UIScreen.main.bounds.width <= 375 ? 14 : 15))
                            .fontWeight(.bold)
                            .foregroundColor(theme == "dark" ? Color.white : Color.black)
                        
                    }
                }
                
                VStack {
                    HStack{
                        Text("7-Day")
                            .font(.system(size: smallFontSize))
                            .foregroundColor(.gray)
                            .padding(.leading, 8)
                        Spacer()
                    }
                    SparklineChartView(sparkline: sparkline, percentageChange: percentageChange)
                }
                
                // Price and Market Cap
                HStack{
                    
                    VStack {
                        Text("24hr")
                            .font(.system(size: smallFontSize))
                            .foregroundColor(.gray)
                        
                        Text("\(String(percentageChange))%")
                            .foregroundColor(percentageChange < 0 ? .red : .green)
                            .font(.system(size: largerFontSize))
                            .fontWeight(.bold)
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text("MCap")
                            .font(.system(size: smallFontSize))
                            .foregroundColor(.gray)
                        
                        Text("\(String(format: marketCap >= 1_000_000 ? "%.2fM" : "%.0fK", marketCap >= 1_000_000 ? marketCap / 1_000_000 : marketCap / 1_000))")
                            .foregroundColor(theme == "dark" ? Color.white : Color.black)
                            .font(.system(size: largerFontSize))
                            .fontWeight(.bold)
                        
                    }
                }
            }
            .containerBackground(for: .widget) {
                theme == "dark" ? Color(.sRGB, red: 0.1, green: 0.1, blue: 0.1, opacity: 1) : Color.white
                    }
    }
}

// MARK: - Preview
//struct SharkCatWidgetView_Previews: PreviewProvider {
//    static var previews: some View {
//        SharkCatWidgetView(price: 0.0051, marketCap: 10_200_000, percentageChange: 5.0)
//            .previewLayout(.sizeThatFits)
//    }
//}

