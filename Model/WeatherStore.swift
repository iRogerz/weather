//
//  WeatherStore.swift
//  weather
//
//  Created by 曾子庭 on 2022/5/12.
//

import Foundation


class WeatherStore{
    
    
    private(set) var weathers: [CurrentWeatherData] = []
    
    func remove(_ index:Int){
        weathers.remove(at: index)
    }
    
    func append(_ weather:CurrentWeatherData){
        weathers.append(weather)
    }
    
}
