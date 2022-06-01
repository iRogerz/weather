//
//  MainViewController.swift
//  weather
//
//  Created by 曾子庭 on 2022/5/10.
//

import UIKit
import SnapKit
import CoreLocation

var timer: Timer?
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
    
    let refreshControl: UIRefreshControl = {
       let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(callAPI), for: .valueChanged)
        return refreshControl
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
        callAPI()
        //API大概10分鐘才會更新一次，我設定一分鐘就偵測一次
        timer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(callAPI), userInfo: nil, repeats: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
    }

    @objc func callAPI(){
        WeatherStore.shared.updateAPI()
        WeatherStore.shared.callBackReloadData = {index in
            DispatchQueue.main.async {
                self.mainTableView.reloadSections(IndexSet(integer: index), with: .automatic)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) { [self] in
            refreshControl.endRefreshing()
        }
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
        mainTableView.addSubview(refreshControl)
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
        let searchMenu = UIMenu(title: "", options: .displayInline, children: [
            UIAction(title: "Coordinate Search", image: UIImage(systemName: "magnifyingglass"), handler: { _ in
                self.coordinateSearchViewController.view.backgroundColor = .black
                self.navigationController?.pushViewController(self.coordinateSearchViewController, animated: true)
            }),
            UIAction(title: "ZIP Code Search", image: UIImage(systemName: "magnifyingglass.circle"), handler: { _ in
                self.navigationController?.pushViewController(self.searchTableViewController, animated: true)
            }),
        ])
        
        let subMenu = UIMenu(title: "", options: .displayInline, children: [systemMenu, searchMenu])
        
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
        cell.timeLabel.text = currentWeather.dt.stringTime
        cell.destributionLabel.text = currentWeather.weather[indexPath.row].description
        cell.tempLabel.text = String(lround(currentWeather.main.temp))
        cell.temp_MaxMin.text = "H: \(lround(currentWeather.main.temp_max))   L: \(lround(currentWeather.main.temp_min))"
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
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return WeatherStore.shared.weathers.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MainPageViewController()
        vc.initialPage = indexPath.section
        let tabbarNC = UINavigationController(rootViewController: vc)
        tabbarNC.modalPresentationStyle = .fullScreen
        present(tabbarNC, animated: true)
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
            print(latitude)
            print(longitude)
            WeatherService.getWeather(by: .coord(latitude, longitude)) { result in
                switch result {
                case .success(let data):
                    // get weather data
                    WeatherStore.shared.changeLocation(data: data)
                    DispatchQueue.main.async { [self] in
                        self.mainTableView.reloadData()
                    }
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            }
        }
    }
}
