import Foundation

class WeatherService {
    
    private let apiKey = "671db5b52b8214a9c02c6b3c6b5bb9f2"
    
    func fetchWeather(for city: String) async throws -> WeatherResponse {
        
        let cityQuery = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? city
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityQuery)&units=metric&appid=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoded = try JSONDecoder().decode(WeatherResponse.self, from: data)
        
        return decoded
    }
}
