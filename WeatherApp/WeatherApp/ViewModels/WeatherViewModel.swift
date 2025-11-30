import Foundation
import Combine

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherResponse?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let service = WeatherService()
    
    func fetchWeather(for city: String) async {
        isLoading = true
        errorMessage = nil
        
        do{
            let result = try await service.fetchWeather(for: city)
            self.weather = result
        } catch {
            self.errorMessage = "Failed to load weather."
            print("Error:", error)
        }
        
        isLoading = false
    }
}
