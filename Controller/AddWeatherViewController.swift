//
//  AddWeatherViewController.swift
//  weather
//
//  Created by 曾子庭 on 2022/5/14.
//

import UIKit

class AddWeatherViewController: UIViewController {
    
    let addWeatherView = AddWeatherView()
    var tempWeatherData:CurrentWeatherData? = nil
    
    var delegate: SaveWeatherDelegate?
    
    override func loadView() {
        self.view = addWeatherView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemGroupedBackground
        view.overrideUserInterfaceStyle = .dark
        setupNavigation()
    }
    
    func setupNavigation(){
        navigationItem.title = "Weather"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButton))
        
        //設定各物件顏色
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.white]
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
//    func selectURL(city: String) -> URL{
//        let address = "https://api.openweathermap.org/data/2.5/weather?"
//        let urlResult = URL(string: address + "q=\(city)&units=metric" + "&appid=" + APIKeys.apikey)
//        return urlResult!
//    }
//    func selectURL(lat: String, lon: String) -> URL{
//        let address = "https://api.openweathermap.org/data/2.5/weather?"
//        let urlResult = URL(string: address + "lat=\(lat)" + "&lon=\(lon)" + "&appid=\(APIKeys.apikey)")!
//        return urlResult
//    }
    
    func buildRequest(parameters: [String: Any]) -> URL? {
        var components = URLComponents(string: "https://api.openweathermap.org/data/2.5/weather")
        var queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        queryItems.append(URLQueryItem(name: "appid", value: APIKeys.apikey))
        components?.queryItems = queryItems
        print(components?.url)
        return components?.url
    }
    
    func getWeather() {
        WeatherService.getWeather(by: .city("taiwan")) { result in
            switch result {
            case .success(let data):
                // get weather data
                break
            case .failure(let error):
                break
            }
        }
    }
    
    func getWeatherData(url: URL?){
        if let url = url {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error{
                    print("Error \(error.localizedDescription)")
                }else if let response = response as? HTTPURLResponse, let data = data{
                    
                    print("Status code \(response.statusCode)")
                    
                    let decoder = JSONDecoder()
                    if let Data = try? decoder.decode(CurrentWeatherData.self, from: data){
                        
                        //需修改！！！！！！
                        print(Data)
                        self.tempWeatherData = Data
                        //需修改！！！！！！
                        
                        DispatchQueue.main.async {
                            self.addWeatherView.locationLabel.text = Data.name
                            self.addWeatherView.tempLabel.text = String(Data.main.temp)
                            self.addWeatherView.destributionLabel.text = Data.weather[0].description
                            self.addWeatherView.temp_MaxMin.text = "H:\(Data.main.temp_max) L:\(Data.main.temp_min)"
                        }
                    }
                }
            }.resume()
        }
    }
    
    @objc func cancelButton(){
        self.dismiss(animated: true)
    }

    @objc func saveButton(){
        delegate?.saveWeather(weatherData: tempWeatherData!)
//        dismiss(animated: true, completion: {
//            self.presentingViewController?.dismiss(animated: false)
//        })
        view.window?.rootViewController?.dismiss(animated: true)
    }
}
