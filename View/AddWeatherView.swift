//
//  AddWeatherView.swift
//  weather
//
//  Created by 曾子庭 on 2022/5/15.
//

import UIKit

class AddWeatherView: UIView {
    
    //MARK: - UI
    let locationLabel:UILabel = {
        let label = UILabel()
        label.text = "qweqe"
        return label
    }()
    
    let tempLabel: UILabel = {
        let label = UILabel()
        label.text = "ssss"
        return label
    }()
    
    let destributionLabel:UILabel = {
        let label = UILabel()
        label.text = "qwwe"
        return label
    }()
    
    let temp_MaxMin: UILabel = {
        let label = UILabel()
        label.text = "SDFWF"
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
    
        let labelStackView = UIStackView(arrangedSubviews: [
            locationLabel, tempLabel, destributionLabel, temp_MaxMin
        ])
        
        self.addSubview(labelStackView)
        
        labelStackView.axis = .vertical
        labelStackView.snp.makeConstraints { make in
            make.top.equalTo(self).offset(100)
            make.centerX.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}
