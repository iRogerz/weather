//
//  CurrentWeatherData.swift
//  weather
//
//  Created by 曾子庭 on 2022/5/10.
//

import Foundation


struct CurrentWeatherData: Decodable{
    var name: String
    var dt: TimeInterval
    var id: Int
    var coord: Coord
    var weather: [Weather]
    var main: Main
}

struct Coord: Decodable{
    var lon: Double
    var lat: Double
}

struct Weather: Decodable{
    var icon: String
    var main: String
    var description: String
}

struct Main: Decodable{
    var temp: Double
    var temp_min: Double
    var temp_max: Double
    var humidity: Int
}


