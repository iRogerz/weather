//
//  WeatherStore.swift
//  weather
//
//  Created by 曾子庭 on 2022/5/12.
//

import Foundation


class WeatherStore{
    
//    static let instance = WeatherStore()
    
    private(set) var weathers: [CurrentWeatherData] = []
    
    func remove(_ index:Int){
        weathers.remove(at: index)
    }
    func removeLast(){
        weathers.removeLast()
    }
    
    func append(_ weather:CurrentWeatherData){
        weathers.append(weather)
    }
    
//    private init(){}
    
}
