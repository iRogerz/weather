//
//  MainHeaderCollectionReusableView.swift
//  weather
//
//  Created by 曾子庭 on 2022/6/7.
//

import UIKit

class MainHeaderCollectionReusableView: UICollectionReusableView {
        
    static let identifier = "mainHeaderCollectionReusableView"
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "header"
        label.tintColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
    
    func configure(){
        backgroundColor = .systemGreen
        addSubview(headerLabel)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        headerLabel.frame = bounds
    }
}
