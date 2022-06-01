//
//  WeatherStore.swift
//  weather
//
//  Created by 曾子庭 on 2022/5/12.
//

import Foundation


class WeatherStore{
    
    //signleton
    static let shared = WeatherStore()
    var callBackReloadData:((Int) -> (Void))?
    
    private let userDefault = UserDefaults.standard
    
    private(set) var weathers: [CurrentWeatherData] = []{
        didSet{
            saveData()
        }
    }
    
    func updateAPI(){
        for index in 0...weathers.count-1{
            WeatherService.getWeather(by: .city(weathers[index].name)) { result in
                switch result {
                case .success(let data):
                    // get weather data
                    if self.weathers[index].dt != data.dt{
                        self.weathers[index] = data
                        self.callBackReloadData?(index)
                    }
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            }
        }
    }
    
    func remove(_ index:Int){
        weathers.remove(at: index)
    }
    func removeLast(){
        weathers.removeLast()
    }
    
    func append(_ weather:CurrentWeatherData){
        weathers.append(weather)
    }
    func changeLocation(data:CurrentWeatherData){
        if weathers.isEmpty{
            weathers.insert(data, at: 0)
        }else{
            weathers[0] = data
        }
    }
    
    private func saveData(){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(weathers){
            let defaults = userDefault
            defaults.set(encoded, forKey: "data")
        }
    }
    
    private func loadData(){
        if let saveData = userDefault.object(forKey: "data") as? Data{
            let decoder = JSONDecoder()
            if let loadedData = try? decoder.decode(Array<CurrentWeatherData>.self, from: saveData) {
                weathers = loadedData
            }
        }
    }
    private init(){
        loadData()
    }
    
}
