//
//  HourlyCollectionViewCell.swift
//  weather
//
//  Created by 曾子庭 on 2022/6/6.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "hourlyCollectionView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews(){
        backgroundColor = UIColor.red
    }
}
