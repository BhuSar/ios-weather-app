import SwiftUI

struct ContentView: View {
    @StateObject var vm = WeatherViewModel()
    @State private var city = ""

    // CUSTOM NEON COLORS
    let neonPink = Color(red: 1.0, green: 0.1, blue: 1.0)      // #FF1AFF (REAL neon pink)
    let neonYellow = Color(red: 1.0, green: 0.9, blue: 0.0)    // neon yellow
    let neonCyan = Color(red: 0.0, green: 1.0, blue: 1.0)      // neon cyan
    let neonBlue = Color(red: 0.2, green: 0.4, blue: 1.0)      // neon blue

    var body: some View {
        ZStack {
            // MARK: - Black Background
            Color.black
                .ignoresSafeArea()

            VStack(spacing: 25) {

                // MARK: - Title
                Text("Weather")
                    .font(.largeTitle.bold())
                    .foregroundStyle(neonCyan)
                    .shadow(color: neonCyan.opacity(0.8), radius: 10)
                    .padding(.top, 20)

                // MARK: - Search Input
                TextField("Enter city name...", text: $city)
                    .padding()
                    .foregroundColor(neonPink)            // NEON PINK TEXT
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(neonYellow, lineWidth: 2)  // Yellow border
                            .shadow(color: neonYellow.opacity(0.9), radius: 8)
                    )
                    .padding(.horizontal)

                // MARK: - Button
                Button {
                    Task { await vm.fetchWeather(for: city) }
                } label: {
                    Text("Get Weather")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(neonBlue)
                        .cornerRadius(12)
                        .shadow(color: neonBlue.opacity(0.7), radius: 12)
                }
                .padding(.horizontal)

                // MARK: - Loading Spinner
                if vm.isLoading {
                    ProgressView()
                        .tint(neonCyan)
                }

                // MARK: - Weather Results
                if let w = vm.weather {
                    VStack(spacing: 10) {
                        Text(w.name)
                            .font(.title)
                            .foregroundColor(neonCyan)
                            .shadow(color: neonCyan.opacity(0.8), radius: 8)

                        Text("\(Int(w.main.temp))°C")
                            .font(.system(size: 60).bold())
                            .foregroundColor(neonPink)
                            .shadow(color: neonPink.opacity(0.9), radius: 10)

                        Text(w.weather.first?.description.capitalized ?? "")
                            .foregroundColor(neonCyan.opacity(0.8))

                        Text("Feels like: \(Int(w.main.feels_like))°C")
                            .foregroundColor(neonYellow)

                        Text("Humidity: \(w.main.humidity)%")
                            .foregroundColor(neonBlue)
                    }
                    .padding(.top, 20)
                }

                // MARK: - Error
                if let error = vm.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                }

                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}
