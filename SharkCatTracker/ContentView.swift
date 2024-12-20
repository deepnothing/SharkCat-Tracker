import SwiftUI
import WidgetKit

struct ContentView: View {
    // Use AppStorage to save user preferences to the shared UserDefaults
    @AppStorage("theme", store: UserDefaults(suiteName: "group.sharkcat.widget")) var theme: String = "light"
        
    var body: some View {
        let screenHeight = UIScreen.main.bounds.height
        let dynamicSpacing = screenHeight * 0.02
        
        VStack(spacing: dynamicSpacing){
                Text("Install Widget")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(theme == "dark" ? Color.white : Color.black)
                 
                HStack(spacing: 20){
                    Text("Edit home screen and select 'Add widget'. Then search for SC tracker")
                        .multilineTextAlignment(.center)
                        .frame(maxHeight: .infinity)
                    Image("schelp2")
                        .resizable()
                        .frame(width: 190, height: 150)
                        .cornerRadius(15)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
                }
                Text("OR")
                    .fontWeight(.bold)
                    .font(.headline)
                HStack(spacing: 20){
                    Text("Long press the SC tracker app, then click on the widget icon")
                        .multilineTextAlignment(.center)
                        .frame(maxHeight: .infinity)
                    Image("schelp1")
                        .resizable()
                        .frame(width: 190, height: 150)
                        .cornerRadius(15)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)

                }
                Text("Select Theme")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(theme == "dark" ? Color.white : Color.black)
                Text("*switching between these refreshes the widget. If done too often it can trigger a rate limit on the api providing price data")
                    .multilineTextAlignment(.center)
                    .font(.system(size: 11))
                    .foregroundColor(.gray)
                
                Button(action: {
                    theme = "light"
                    // Notify widget of change
                    let sharedDefaults = UserDefaults(suiteName: "group.sharkcat.widget")
                    sharedDefaults?.set("light", forKey: "theme")
                    sharedDefaults?.synchronize() // Ensures the value is saved immediately
                    WidgetCenter.shared.reloadAllTimelines() // Trigger widget reload
                    print("Theme changed to Light Mode")
                }) {
                    Text("Light Mode")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(theme == "light" ? Color.blue : Color.gray)
                        .cornerRadius(12)
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                }
                
                Button(action: {
                    theme = "dark"
                    // Notify widget of change
                    let sharedDefaults = UserDefaults(suiteName: "group.sharkcat.widget")
                    sharedDefaults?.set("dark", forKey: "theme")
                    sharedDefaults?.synchronize() // Ensures the value is saved immediately
                    WidgetCenter.shared.reloadAllTimelines() // Trigger widget reload
                    print("Theme changed to Dark Mode")

                }) {
                    Text("Dark Mode")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(theme == "dark" ? Color.blue : Color.gray)
                        .cornerRadius(12)
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                }
            }
        .padding()
        .frame(maxHeight: .infinity)
        .background(theme == "dark" ? Color.black : Color.white)
        .foregroundColor(theme == "dark" ? Color.white : Color.black)
    }
}

#Preview {
    ContentView()
}

