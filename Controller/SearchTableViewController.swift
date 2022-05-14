//
//  SearchTableViewController.swift
//  weather
//
//  Created by 曾子庭 on 2022/5/11.
//

import UIKit

class SearchTableViewController: UITableViewController {

    
    var allCountry = AllCountry()
    var tempCountry = [String]()
    var weatherStore = WeatherStore()

    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.overrideUserInterfaceStyle = .dark
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.snp.makeConstraints { make in
            
        }
    }
    
    
    func getWeatherData(city: String){
        let address = "https://api.openweathermap.org/data/2.5/weather?"
        if let url = URL(string: address + "q=\(city)&units=metric" + "&appid=" + APIKeys.apikey) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error{
                    print("Error \(error.localizedDescription)")
                }else if let response = response as? HTTPURLResponse, let data = data{
                    
                    print("Status code \(response.statusCode)")
                    
                    let decoder = JSONDecoder()
                    if let Data = try? decoder.decode(CurrentWeatherData.self, from: data){
                        //把要做的事情放這裡
                        self.weatherStore.append(Data)
                        print(Data.weather[0].description)
//                        DispatchQueue.main.async {
//                            self.MainTableView.reloadData()
//                        }
                    }
                }
            }.resume()
        }
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempCountry.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = tempCountry[indexPath.row]
        cell.textLabel?.text = item
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = AddWeatherViewController()
//        vc.saveAlarmDataDelegate = self
//        let weather = weatherStore.weathers[indexPath.row]
        
        let addWeatherNC = UINavigationController(rootViewController: vc)
        present(addWeatherNC, animated: true, completion: nil)
    }
}


