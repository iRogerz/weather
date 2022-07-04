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

    
    func getWeather(_ weatherMethod: WeatherMethod){
        WeatherService.getWeather(by: weatherMethod) { result in
            switch result {
            case .success(let data):
                // get weather data
                self.tempWeatherData = data
                DispatchQueue.main.async { [self] in
                    addWeatherView.locationLabel.text = data.name
                    addWeatherView.tempLabel.text = String(data.main.temp)
                    addWeatherView.destributionLabel.text = data.weather[0].description
                    addWeatherView.temp_MaxMin.text = "H:\(data.main.temp_max) L:\(data.main.temp_min)"
                }
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    
    @objc func cancelButton(){
        self.dismiss(animated: true)
    }
    
    @objc func saveButton(){
        delegate?.saveWeather(weatherData: tempWeatherData!)
        //        dismiss(animated: true)
        view.window?.rootViewController?.dismiss(animated: true)
    }
}

//extension AddWeatherViewController:UICollectionViewDataSource{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//        return cell
//    }
//
//
//}
//

