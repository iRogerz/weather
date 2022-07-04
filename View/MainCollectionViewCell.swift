//
//  MainCollectionViewCell.swift
//  weather
//
//  Created by 曾子庭 on 2022/6/6.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "mainCollectionView"
    
    //MARK: - UI
    
    let hourlyCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 50, height: 100)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .brown
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(HourlyCollectionViewCell.self, forCellWithReuseIdentifier: HourlyCollectionViewCell.identifier)
        return collectionView
    }()
    
    let fiveDayForcastTableView:UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = false
        tableView.allowsSelection = false
        tableView.register(FiveDayForecastTableViewCell.self, forCellReuseIdentifier: "fiveDay")
        return tableView
    }()
    
    let temperatureView:UIView = {
        let view = UIView()
        
        return view
    }()
    
    let descriptView:UIView = {
        let view = UIView()
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .cyan
        layer.cornerRadius = 20
        delegate()
    }
    
    func delegate(){
        hourlyCollectionView.dataSource = self
//        hourlyCollectionView.delegate = self
        fiveDayForcastTableView.dataSource = self
        fiveDayForcastTableView.delegate = self
        
    }
    
    //MARK: - setupUI
    func setupHourlyCollectionView(){
        addSubview(hourlyCollectionView)
        hourlyCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupFiveDayForcastTableView(){
        addSubview(fiveDayForcastTableView)
        fiveDayForcastTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupTemperatureView(){
        addSubview(temperatureView)
        temperatureView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupDescriptView(){
        addSubview(descriptView)
        descriptView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - tableView
extension MainCollectionViewCell:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "fiveDay", for: indexPath) as? FiveDayForecastTableViewCell else{ return UITableViewCell() }
        let data = WeatherStore.shared.weathers[indexPath.section]
        cell.textLabel?.text = "Today"
        cell.tempMinLabel.text = String(data.main.temp_min)
        cell.tempMaxLabel.text = String(data.main.temp_max)
        return cell
    }
}

extension MainCollectionViewCell:UITableViewDelegate{
    
}

//MARK: - MaincollectionView
extension MainCollectionViewCell:UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    //主要的cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyCollectionViewCell.identifier, for: indexPath) as? HourlyCollectionViewCell else{ return UICollectionViewCell() }
        
        //        cell.contentView.layer.cornerRadius = 10
        
        return cell
    }
    
}
//extension MainCollectionViewCell: UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 4, bottom: 16, right: 4)
//    }
//    //cell的寬高
//
//}
    


