//
//  MainViewController.swift
//  weather
//
//  Created by 曾子庭 on 2022/5/10.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    var allCountry = AllCountry()
    var weatherStore = WeatherStore()
    var searchTableViewController = SearchTableViewController()
    
    
    
    let mainTableView:UITableView = {
        let mainTableView = UITableView(frame: .zero, style: .insetGrouped)
        mainTableView.register(MainTableViewCell.self, forCellReuseIdentifier: "cell")
        //        mainTableView.rowHeight = 100
        return mainTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        mainTableView.dataSource = self
        mainTableView.delegate = self
        setupNavigation()
        getCountry()
        setupUI()
    }
    
    func setupUI(){
        view.addSubview(mainTableView)
        mainTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    private func setupNavigation(){
        navigationItem.title = "Weather"
        navigationItem.rightBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(newList))
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let searchController = UISearchController(searchResultsController: searchTableViewController)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    @objc func newList(){
        getWeatherData(city: "Tainan")
    }
    
    func getCountry(){
        let address = "https://countriesnow.space/api/v0.1/countries"
        if let url = URL(string: address) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error{
                    print("Error \(error.localizedDescription)")
                }else if let response = response as? HTTPURLResponse, let data = data{
                    
                    print("Status code \(response.statusCode)")
                    
                    let decoder = JSONDecoder()
                    if let Data = try? decoder.decode(CountryData.self, from: data){
                        //把要做的事情放這裡
                        for i in 0..<Data.data.count{
                            self.allCountry.append(Data.data[i].country)
                        }
                    }
                }
            }.resume()
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
                        self.weatherStore.append(Data)
                        print(self.weatherStore.weathers.count)
                        DispatchQueue.main.async {
                            self.mainTableView.reloadData()
                        }
                        
                    }
                }
            }.resume()
        }
    }
    
}

extension MainViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MainTableViewCell else {return UITableViewCell()}
        print("qwweeee")
        let currentWeather = weatherStore.weathers[indexPath.row]
        cell.locationLabel.text = currentWeather.name
        cell.timeLabel.text = "暫時沒有"
        cell.destributionLabel.text = currentWeather.weather[indexPath.row].description
        cell.tempLabel.text = String(currentWeather.main.temp)
        cell.temp_MaxMin.text = String(currentWeather.main.temp_max) + ":" + String(currentWeather.main.temp_min)
        //        cell.textLabel?.text = currentWeather.name
        //        cell.detailTextLabel?.text = currentWeather.weather[indexPath.row].description
        //        cell.backgroundColor = UIColor.white
        //        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        //        cell.layer.cornerRadius = 8
        //        cell.clipsToBounds = true
        return cell
    }
    
}


extension MainViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return weatherStore.weathers.count
    }
}

extension MainViewController:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, searchText.isEmpty == false{
            searchTableViewController.tempCountry = allCountry.countrys.filter({ country in
                country.localizedStandardContains(searchText)
            })
        }else{
            searchTableViewController.tempCountry = []
        }
        searchTableViewController.tableView.reloadData()
    }
}


extension MainViewController:SaveWeatherDelegate{
    func saveWeather(weatherData: CurrentWeatherData) {
        weatherStore.append(weatherData)
        print(weatherStore.weathers.count)
        DispatchQueue.main.async {
            self.mainTableView.reloadData()
        }

    }
}

protocol SaveWeatherDelegate:AnyObject{
    func saveWeather(weatherData:CurrentWeatherData)
}
