//
//  AddWeatherViewController.swift
//  weather
//
//  Created by 曾子庭 on 2022/5/14.
//

import UIKit

class AddWeatherViewController: UIViewController {

    
    var weatherStore = WeatherStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .clear
        view.overrideUserInterfaceStyle = .dark
        setupNavigation()
    }
    
    func setupNavigation(){
        navigationItem.title = "Add Alarm"
//        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButton))
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButton))
        
        //設定各物件顏色
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.white]
        navigationItem.rightBarButtonItem?.tintColor = .orange
        navigationItem.leftBarButtonItem?.tintColor = .orange
    }
}
