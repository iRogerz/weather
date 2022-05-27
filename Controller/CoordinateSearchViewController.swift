//
//  CoordinateSearchViewController.swift
//  weather
//
//  Created by 曾子庭 on 2022/5/25.
//

import UIKit

class CoordinateSearchViewController: UIViewController {
    
    var delegate:SaveWeatherDelegate?
    
    //MARK: - UI
    let label:UILabel = {
        let label = UILabel()
        label.text = "Search by Coordinate"
        return label
    }()
    
    let lat:UITextField = {
        let lat = UITextField()
        lat.placeholder = "please input lat"
        lat.clearButtonMode = .whileEditing
        lat.keyboardType = .numbersAndPunctuation
        lat.borderStyle = .roundedRect
        return lat
    }()
    
    let lon:UITextField = {
        let lon = UITextField()
        lon.placeholder = "please input lon"
        lon.clearButtonMode = .whileEditing
        lon.keyboardType = .numbersAndPunctuation
        lon.borderStyle = .roundedRect
        //        myTextField.returnKeyType = .done
        return lon
    }()
    
    let searchButton:UIButton = {
        let button = UIButton()
        button.setTitle("Search", for: .normal)
        //        button.tintColor = .black
        button.backgroundColor = .lightGray
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(search), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    func setupUI(){
        let stackView = UIStackView(arrangedSubviews: [
            label, lat, lon, searchButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 15
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(80)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(50)
        }
    }
    
    
    @objc func search(){
        let vc = AddWeatherViewController()
        if let lat = lat.text,let lon = lon.text{
            if (lat != "" && lon != ""){
                
            }
            vc.getWeather(.coord(lat, lon))
            vc.delegate = self.delegate
            let addWeatherNC = UINavigationController(rootViewController: vc)
            present(addWeatherNC, animated: true, completion: nil)
            navigationController?.popViewController(animated: true)
        }
        
    }
    
    
}
