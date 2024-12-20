import Foundation

struct CoinData: Decodable {
    let image: CoinImage
    let marketData: CoinMarketData

    enum CodingKeys: String, CodingKey {
        case image
        case marketData = "market_data"
    }
}

struct CoinImage: Decodable {
    let thumb: String
    let small: String
    let large: String
}

struct CoinMarketData: Decodable {
    let currentPrice: [String: Double]
    let marketCap: [String: Double]
    let priceChangePercentage24h: Double
    let sparkline7d: SparklineData

    enum CodingKeys: String, CodingKey {
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case priceChangePercentage24h = "price_change_percentage_24h"
        case sparkline7d = "sparkline_7d"
    }
}

struct SparklineData: Decodable {
    let price: [Double]
}

class APIManager {
    static let shared = APIManager()
    private let baseURL = "https://api.coingecko.com/api/v3/coins/shark-cat"

    func fetchCoinData(completion: @escaping (CoinData?) -> Void) {
        // Set up query parameters
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.queryItems = [
            URLQueryItem(name: "localization", value: "false"),
            URLQueryItem(name: "tickers", value: "false"),
            URLQueryItem(name: "market_data", value: "true"),
            URLQueryItem(name: "community_data", value: "false"),
            URLQueryItem(name: "developer_data", value: "false"),
            URLQueryItem(name: "sparkline", value: "true")
        ]
        
        guard let url = urlComponents?.url else {
            print("Invalid URL")
            completion(nil)
            return
        }

        // Perform the network request
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                // Decode the JSON response into the CoinData model
                let coinData = try JSONDecoder().decode(CoinData.self, from: data)
                print(coinData)
                
                DispatchQueue.main.async {
                    completion(coinData)
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
                completion(nil)
            }
        }
        
        task.resume()
    }
}

