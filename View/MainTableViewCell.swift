//
//  MainTableViewCell.swift
//  weather
//  Created by 曾子庭 on 2022/5/11.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    let locationLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    let timeLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    let destributionLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        
        return label
    }()
    
    
    let tempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 34)
        return label
    }()
    
    let temp_MaxMin: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
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
        leftStackView.setCustomSpacing(24, after: timeLabel)
        rightStackView.axis = .vertical
        rightStackView.alignment = .center
        rightStackView.spacing = 26
        
        leftStackView.snp.makeConstraints { make in
            make.top.equalTo(self).offset(8)
            make.leading.equalTo(self).offset(14)
        }
        
        rightStackView.snp.makeConstraints { make in
            make.trailing.equalTo(self).offset(-16)
            make.top.equalTo(self).offset(8)
        }
        
        
    }
    
    
}
