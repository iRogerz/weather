//
//  MainViewController.swift
//  weather
//
//  Created by 曾子庭 on 2022/5/10.
//

import UIKit
import SnapKit
import CoreLocation

class MainViewController: UIViewController {
    
    var allCountry = AllCountry()
    var searchTableViewController = SearchTableViewController()
    var coordinateSearchViewController = CoordinateSearchViewController()
    let locationManager = CLLocationManager()
    
    //MARK: - UI
    let mainTableView:UITableView = {
        let mainTableView = UITableView(frame: .zero, style: .insetGrouped)
        mainTableView.register(MainTableViewCell.self, forCellReuseIdentifier: "cell")
        //        mainTableView.rowHeight = 100
        return mainTableView
    }()
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        delegate()
        location()
        setupNavigation()
        setupUI()
        allCountry.getCountry()
    }
    
    func delegate(){
        mainTableView.dataSource = self
        mainTableView.delegate = self
        searchTableViewController.delegate = self
        coordinateSearchViewController.delegate = self
    }
    
    func location(){
        locationManager.delegate = self  //委派給ViewController
        locationManager.desiredAccuracy = kCLLocationAccuracyBest  //設定為最佳精度
        locationManager.requestWhenInUseAuthorization()  //user授權
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()  //開始update user位置
    }
    
    private func setupUI(){
        view.addSubview(mainTableView)
        mainTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
    private func setupNavigation(){
        let systemMenu = UIMenu(title: "",options: .displayInline, children: [
            UIAction(title: "Edit List", image: UIImage(systemName: "pencil"), handler: { (_) in
                
            }),
            UIAction(title: "Notification", image: UIImage(systemName: "bell.badge"), handler: { (_) in
            }),
        ])
        let tempMenu = UIMenu(title: "", options: .singleSelection, children: [
            UIAction(title: "Celsius", image: UIImage(systemName: "magnifyingglass"),state: .on, handler: { (_) in
                
            }),
            UIAction(title: "Fahrenheit", image: UIImage(systemName: "magnifyingglass.circle"), handler: { (_) in
                
            }),
        ])
        let searchMenu = UIMenu(title: "", options: .displayInline, children: [
            UIAction(title: "Coordinate Search", image: UIImage(systemName: "magnifyingglass"), handler: { (_) in
                self.navigationController?.pushViewController(self.coordinateSearchViewController, animated: true)
            }),
            UIAction(title: "ZIP Code Search", image: UIImage(systemName: "magnifyingglass.circle"), handler: { (_) in
                self.navigationController?.pushViewController(self.searchTableViewController, animated: true)
            }),
        ])
        
        let subMenu = UIMenu(title: "", options: .displayInline, children: [systemMenu, tempMenu ,searchMenu])
        
        navigationItem.title = "Weather"
        navigationItem.rightBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", image: UIImage(systemName: "ellipsis.circle"), primaryAction: nil, menu: subMenu)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        //searchController
        let searchController = UISearchController(searchResultsController: searchTableViewController)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search for a city or a country"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
    }
}

//MARK: - TableView
extension MainViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MainTableViewCell else {return UITableViewCell()}
        let currentWeather = WeatherStore.shared.weathers[indexPath.section]
        cell.locationLabel.text = currentWeather.name
        cell.timeLabel.text = "暫時沒有"
        cell.destributionLabel.text = currentWeather.weather[indexPath.row].description
        cell.tempLabel.text = String(currentWeather.main.temp)
        cell.temp_MaxMin.text = String(currentWeather.main.temp_max) + ":" + String(currentWeather.main.temp_min)
        //        cell.backgroundColor = UIColor.white
        //        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
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
        return WeatherStore.shared.weathers.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AddWeatherViewController()
        let AddWeatherNC = UINavigationController(rootViewController: vc)
        AddWeatherNC.modalPresentationStyle = .fullScreen
        AddWeatherNC.tabBarItem.image = UIImage(systemName: "list.bullet")
        //        AddWeatherNC.modalTransitionStyle = .partialCurl
        present(AddWeatherNC, animated: true)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        print(indexPath.section)
        if indexPath.section != 0{
            if editingStyle == .delete{
                WeatherStore.shared.remove(indexPath.section)
                mainTableView.reloadData()
            }
        }
    }
}

//MARK: - UISearch
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


//MARK: - SaveWeatherDelegate
extension MainViewController:SaveWeatherDelegate{
    func saveWeather(weatherData: CurrentWeatherData) {
        WeatherStore.shared.append(weatherData)
        
        DispatchQueue.main.async {
            self.mainTableView.reloadData()
        }
    }
}

protocol SaveWeatherDelegate:AnyObject{
    func saveWeather(weatherData:CurrentWeatherData)
}

extension MainViewController:CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            // Handle location update
        }
    }
}
