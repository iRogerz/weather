//
//  MainTableViewCell.swift
//  weather
//  Created by 曾子庭 on 2022/5/11.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    let locationLabel:UILabel = {
        let label = UILabel()
        
        
        return label
    }()
    
    let timeLabel:UILabel = {
        let label = UILabel()
        
        
        return label
    }()
    
    let destributionLabel:UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    
    let tempLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let temp_MaxMin: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    //MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI(){
        let leftStackView = UIStackView(arrangedSubviews: [
            locationLabel, timeLabel, destributionLabel
        ])
        
        let rightStackView = UIStackView(arrangedSubviews: [
            tempLabel, temp_MaxMin
        ])
        self.addSubview(leftStackView)
        self.addSubview(rightStackView)
        leftStackView.axis = .vertical
        rightStackView.axis = .vertical
        
        leftStackView.snp.makeConstraints { make in
            make.leading.equalTo(self).offset(14)
        }
        
        rightStackView.snp.makeConstraints { make in
            make.trailing.equalTo(self).offset(-50)
        }
        
        
    }
    
    
}
