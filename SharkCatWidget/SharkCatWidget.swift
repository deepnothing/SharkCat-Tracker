import WidgetKit
import SwiftUI

struct SharkCatEntry: TimelineEntry {
    let date: Date
    let price: Double
    let marketCap: Double
    let priceChangePercentage: Int // Rounding to nearest whole number
    let imageUrl: String
    let sparkline: [Double]
    let theme: String
}

struct SharkCatProvider: TimelineProvider {
    func placeholder(in context: Context) -> SharkCatEntry {
        SharkCatEntry(date: Date(), price: 0.00, marketCap: 000000, priceChangePercentage: 0, imageUrl: "", sparkline: [], theme: "light")
    }

    func getSnapshot(in context: Context, completion: @escaping (SharkCatEntry) -> Void) {
        let entry = SharkCatEntry(date: Date(), price: 0.00, marketCap: 000000, priceChangePercentage: 0, imageUrl: "", sparkline: [], theme: "light")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SharkCatEntry>) -> Void) {
        
        // set widget theme
        let sharedDefaults = UserDefaults(suiteName: "group.sharkcat.widget")
        let theme = sharedDefaults?.string(forKey: "theme") ?? "light" // Default to light mode if not set
        
        APIManager.shared.fetchCoinData { coinData in
            let currentDate = Date()
            let refreshDate = Calendar.current.date(byAdding: .minute, value: 15, to: currentDate) ?? currentDate
            

            let entry: SharkCatEntry
            if let coinData = coinData {
                // Extract the data from the coinData object
                let price = coinData.marketData.currentPrice["usd"] ?? 0.0
                let marketCap = coinData.marketData.marketCap["usd"] ?? 0.0
                let priceChangePercentage = coinData.marketData.priceChangePercentage24h
                let imageUrl = coinData.image.thumb
                let sparkline = coinData.marketData.sparkline7d.price
                
                // Round the priceChangePercentage to the nearest whole number
                let roundedPriceChangePercentage = Int(round(priceChangePercentage))
                
                // Create the entry with the rounded price change percentage
                entry = SharkCatEntry(date: currentDate, price: price, marketCap: marketCap, priceChangePercentage: roundedPriceChangePercentage, imageUrl: imageUrl, sparkline: sparkline, theme: theme)
            } else {
                // Use placeholder data on failure
                entry = SharkCatEntry(date: currentDate, price: 0.00, marketCap: 0000000, priceChangePercentage: 0, imageUrl: "", sparkline: [], theme: "light")
            }
            
            // Create and return the timeline
            let timeline = Timeline(entries: [entry], policy: .after(refreshDate))
            completion(timeline)
        }
    }
}

struct SharkCatWidgetEntryView: View {
    var entry: SharkCatProvider.Entry

    var body: some View {
        SharkCatWidgetView(price: entry.price, marketCap: entry.marketCap, percentageChange: entry.priceChangePercentage, imageUrl: entry.imageUrl, sparkline: entry.sparkline, theme: entry.theme)
    }
}

struct SharkCatWidget: Widget {
    let kind: String = "SharkCatWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: SharkCatProvider()) { entry in
            SharkCatWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("SharkCat Tracker")
        .description("Track the price and market cap of SharkCat Token.")
        .supportedFamilies([.systemSmall])

    }
}

