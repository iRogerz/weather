//
//  FiveDayForecastData.swift
//  weather
//
//  Created by 曾子庭 on 2022/6/6.
//

import Foundation

struct FiveDayForecastData: Codable{
    var list: [List]
    var city: City
    var cnt: Int
    
    struct List: Codable{
        var dt: TimeInterval
        var main: Main
        var weather: Weather
        var clouds: Clouds
        var wind: Wind
        var visibility: Int
    //    var rain: Rain
    }
    //struct Rain: Codable{
    //    var 3h: Double
    //}
    struct Clouds: Codable{
        var all: Int
    }
    struct Wind: Codable{
        var speed: Double
        var deg: Int
        var gust: Double
    }
    struct Main: Codable{
        var temp: Double
        var temp_min: Double
        var temp_max: Double
        var humidity: Int
    }
    struct City: Codable{
        var id: Int
        var name: String
        var coord: Coord
        var country: String
        var timezone: Int
        var sunrise: TimeInterval
        var sunset: TimeInterval
    }

    struct Coord: Codable{
        var lon: Double
        var lat: Double
    }


}
