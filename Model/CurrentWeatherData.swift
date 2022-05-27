//
//  CurrentWeatherData.swift
//  weather
//
//  Created by 曾子庭 on 2022/5/10.
//

import Foundation


struct CurrentWeatherData: Codable{
    var name: String
    var dt: TimeInterval
    var id: Int
    var coord: Coord
    var weather: [Weather]
    var main: Main
}

struct Coord: Codable{
    var lon: Double
    var lat: Double
}

struct Weather: Codable{
    var icon: String
    var main: String
    var description: String
}

struct Main: Codable{
    var temp: Double
    var temp_min: Double
    var temp_max: Double
    var humidity: Int
}


