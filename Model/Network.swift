//
//  Network.swift
//  weather
//
//  Created by 曾子庭 on 2022/5/27.
//

import Foundation


//很難 多研究
class Network {
    
    static func send(url: String,
                     parameters: [String: Any],
                     completion: @escaping (Result<Data, Error>) -> Void)
    {
        var components = URLComponents(string: url)
        let queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        components?.queryItems = queryItems
        guard let url = components?.url else {
            completion(.failure(NetworkError.urlIsNil))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            if let data = data {
                completion(.success(data))
            }
        }.resume()
    }
}

extension Network {
    
    enum NetworkError: Error, LocalizedError {
        case urlIsNil
        
        var errorDescription: String? {
            switch self {
            case .urlIsNil:
                return "url is nil"
            }
        }
    }
}

class WeatherService {
    
    private static let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    private static let fiveDayURL = "https://api.openweathermap.org/data/2.5/forecast"

    static func getWeather(by method: WeatherMethod,
                           completion: @escaping (Result<CurrentWeatherData, Error>) -> Void) {
        var parameters: [String: Any] = [:]
        //攝氏
        parameters["units"] = "metric"
        switch method {
        case .city(let city):
            parameters["q"] = city
        case .coord(let lat, let lon):
            parameters["lat"] = lat
            parameters["lon"] = lon
        case .code(let code):
            parameters["code"] = code
        }
        parameters["appid"] = APIKey.apiKey
        Network.send(url: baseURL, parameters: parameters) { result in
            switch result {
            case .success(let data):
                do {
                    let decoded = try JSONDecoder().decode(CurrentWeatherData.self, from: data)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

enum WeatherMethod {
    case city(String)
    //應該要放Double
    case coord(Double, Double)
    case code(Int)
}
