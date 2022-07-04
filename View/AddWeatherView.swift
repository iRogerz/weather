//
//  AddWeatherView.swift
//  weather
//
//  Created by 曾子庭 on 2022/5/15.
//

import UIKit
import SnapKit

class AddWeatherView: UIView {
    
    var descript:[Destript] = [
        .uv, .sunset, .wind, .tainfall, .feels_like, .humidity, .visibility, .pressure
    ]
    
    //MARK: - scrollViewUI
    let mainScrollView:UIScrollView = {
        let scrollView = UIScrollView()
        //        scrollView.contentInset.top = 0
        //        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
            scrollView.backgroundColor = .gray
        return scrollView
    }()
    
    let mainContentView:UIView = {
        let  contentView = UIView()
        contentView.backgroundColor = .clear
        return contentView
    }()
    
    let mainCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        //sticky header!!
        layout.sectionHeadersPinToVisibleBounds = true
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .brown
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        collectionView.register(MainHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MainHeaderCollectionReusableView.identifier)
        return collectionView
    }()
    
    
    //MARK: - labelUI
    lazy var labelStackView:UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            locationLabel, tempLabel, destributionLabel, temp_MaxMin
        ])
        stackView.backgroundColor = .blue
        stackView.setCustomSpacing(4, after: destributionLabel)
        stackView.spacing = 8
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    let locationLabel:UILabel = {
        let label = UILabel()
        label.text = "_"
        label.font = UIFont.systemFont(ofSize: 30)
        return label
    }()
    
    let tempLabel: UILabel = {
        let label = UILabel()
        label.text = "_"
        label.font = UIFont.systemFont(ofSize: 50)
        return label
    }()
    
    let destributionLabel:UILabel = {
        let label = UILabel()
        label.text = "_"
        return label
    }()
    
    let temp_MaxMin: UILabel = {
        let label = UILabel()
        label.text = "_"
        return label
    }()
    
    //MARK: - lifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)

        delegate()
        configureSubViews()
        setupConstraints()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func delegate(){
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
    }
    
    //MARK: - seutpUI
    func configureSubViews(){
        
        addSubview(labelStackView)
        addSubview(mainScrollView)
        mainScrollView.addSubview(mainContentView)
        mainContentView.addSubview(mainCollectionView)
    }
    
//    func setupView() {
//        addSubview(labelStackView)
//        labelStackView.snp.makeConstraints { make in
//            make.top.leading.equalTo(safeAreaLayoutGuide).offset(16)
//            make.centerX.equalToSuperview()
//            make.height.equalTo(100)
//        }
//
//        addSubview(mainScrollView)
//        mainScrollView.snp.makeConstraints { make in
//            make.edges.equalTo(safeAreaLayoutGuide).inset(UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0))
//        }
//        mainScrollView.addSubview(mainContentView)
//        mainContentView.snp.makeConstraints { make in
//            make.width.edges.equalToSuperview()
//        }
//
//        let stackView = UIStackView(arrangedSubviews: [
//            fiveDayForcastTableView, temperatureTableView
//        ])
//        stackView.axis = .vertical
//        stackView.spacing = 16
//        stackView.distribution = .fillEqually
//
//        fiveDayForcastTableView.snp.makeConstraints { make in
//            make.height.equalTo(700)
//        }
//
//        mainContentView.addSubview(stackView)
//        stackView.snp.makeConstraints { make in
//            make.edges.equalTo(UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16))
//        }
//    }
    
    func setupConstraints(){
        
        labelStackView.snp.makeConstraints { make in
            make.top.leading.equalTo(safeAreaLayoutGuide).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(150)
        }
        
        mainScrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide).inset(UIEdgeInsets(top: 200, left: 0, bottom: 0, right: 0))
        }
        
        mainContentView.snp.makeConstraints { make in
            make.width.edges.equalToSuperview()
        }
        
        mainCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide).inset(UIEdgeInsets(top: 200, left: 16, bottom: 0, right: 16))
            make.height.equalToSuperview()
        }
        
    }
    
}

//MARK: - MaincollectionView
extension AddWeatherView:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let homeSection = HomeSection(rawValue: section) else {return 0}
        return homeSection == .descript ? descript.count : 1
//        switch homeSection {
//        case .hourlyForcast, .tenDayForcast, .temp, .buttom:
//            return 1
//        default:
//            return 2
//        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return HomeSection.allCases.count
    }
    
    //主要的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else{ return UICollectionViewCell() }
        guard let homeSection = HomeSection(rawValue: indexPath.section) else {return UICollectionViewCell()}
        switch homeSection {
        case .hourlyForcast:
            cell.setupHourlyCollectionView()
        case .fiveDayForcast:
            cell.setupFiveDayForcastTableView()
        case .temp:
            cell.setupTemperatureView()
        case .descript:
            break
        case .buttom:
            break
        }
        return cell
    }
    
    //header的cell
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MainHeaderCollectionReusableView.identifier, for: indexPath) as! MainHeaderCollectionReusableView
        return header
    }
}

extension AddWeatherView: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 4, bottom: 16, right: 4)
    }
    //cell的寬高
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let homeSection = HomeSection(rawValue: indexPath.section) else {return CGSize.zero}
        switch homeSection {
        case .hourlyForcast:
            return CGSize(width: frame.width, height: 100)
        case .fiveDayForcast:
            return CGSize(width: frame.width, height: 220)
        case .temp:
            return CGSize(width: frame.width, height: 200)
        case .descript:
            return CGSize(width: (frame.width-60)/2, height: (frame.width-60)/2)
        case .buttom:
            return CGSize(width: frame.width, height: 60)
//        default:
//            return CGSize(width: (frame.width-50)/2, height: (frame.width-50)/2)
        }

    }
    
    //header寬高
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard let homeSection = HomeSection(rawValue: section) else {return CGSize.zero}
        switch homeSection {
        case .hourlyForcast:
            return CGSize(width: frame.width, height: 36)
        case .fiveDayForcast, .temp:
            return CGSize(width: frame.width, height: 26)
        case .buttom:
            return CGSize.zero
        default:
            return CGSize(width: (frame.width-50)/2, height: 20)
        }
//        return CGSize(width: frame.width, height: 20)
    }
}

//MARK: - Collection section enum
extension AddWeatherView{
    enum HomeSection:Int, CaseIterable{
        case hourlyForcast = 0, fiveDayForcast, temp, descript, buttom
    }
    enum Destript{
        case uv, sunset, wind, tainfall, feels_like, humidity, visibility, pressure
        
        var title: String{
            switch self {
            case .uv:
                return "UV INDEX"
            case .sunset:
                return "SUNSET"
            case .wind:
                return "WIND"
            case .tainfall:
                return "RAINFALL"
            case .feels_like:
                return "FEELS LIKE"
            case .humidity:
                return "HUMIDITY"
            case .visibility:
                return "VISIBILITY"
            case .pressure:
                return "PRESSURE"
            }
        }
    }
}
