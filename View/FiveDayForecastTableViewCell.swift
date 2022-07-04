//
//  FiveDayForecastTableViewCell.swift
//  weather
//
//  Created by 曾子庭 on 2022/6/6.
//

import UIKit

class FiveDayForecastTableViewCell: UITableViewCell {

    //MARK: - UI
    let weekLabel: UILabel = {
        var label = UILabel()
        
        return label
    }()
    
    let icon: UIImageView = {
       let icon = UIImageView()
        return icon
    }()
    let tempMinLabel: UILabel = {
        var label = UILabel()
        
        return label
    }()
    
    let tempMaxLabel: UILabel = {
        var label = UILabel()
        
        return label
    }()
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [weekLabel, icon, tempMinLabel, tempMaxLabel])
        
        return stackView
    }()
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI(){
        textLabel?.font = UIFont.systemFont(ofSize: 30)
        
        addSubview(tempMinLabel)
        addSubview(tempMaxLabel)
        tempMinLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
        }
        
        tempMaxLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
}

