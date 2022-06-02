//
//  AddWeatherView.swift
//  weather
//
//  Created by 曾子庭 on 2022/5/15.
//

import UIKit

class AddWeatherView: UIView {
    
    //MARK: - UI
//    let headerView:UICollectionReusableView = {
//       let headerView = UICollectionReusableView()
//        
//        return headerView
//    }()
    let scrollView:UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let headerView:UIView = {
        let  headerView = UIView()
        headerView.backgroundColor = .blue
        return headerView
    }()
    
    let contentView:UIView = {
        let  contentView = UIView()
        contentView.backgroundColor = .green
        return contentView
    }()
    
    //主要的collectionView
//    let mainCollectionView:UICollectionView = {
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.init())
//        collectionView.backgroundColor = .brown
//        collectionView.register(UICollectionReusableView.self, forCellWithReuseIdentifier: "header")
//        return collectionView
//    }()
    
//    let hourlyCollectionView:UICollectionView = {
//        let collectionView = UICollectionView()
//
//        return collectionView
//    }()
 
//    let tenDayForcast:UITableView = {
//        let tableView = UITableView()
//        tableView.backgroundColor = .red
//        return tableView
//    }()
//    
//    let temperature:UITableView = {
//        let tableView = UITableView()
//        
//        return tableView
//    }()
//    
//    let destriptionCollectionView:UICollectionView = {
//       let destriptionCollectionView = UICollectionView()
//        
//        return destriptionCollectionView
//    }()

    lazy var labelStackView:UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            locationLabel, tempLabel, destributionLabel, temp_MaxMin
        ])
        stackView.axis = .vertical
        return stackView
    }()
    
    let locationLabel:UILabel = {
        let label = UILabel()
        label.text = "_"
        return label
    }()
    
    let tempLabel: UILabel = {
        let label = UILabel()
        label.text = "_"
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
//        mainCollectionView.dataSource = self
    }
    
    func configureSubViews(){
        self.addSubview(scrollView)
        scrollView.addSubview(headerView)
        headerView.addSubview(labelStackView)
        scrollView.addSubview(contentView)
//        scrollView.addSubview(mainCollectionView)
//        contentView.addSubview(hourlyCollectionView)
//        contentView.addSubview(tenDayForcast)
//        contentView.addSubview(temperature)
//        contentView.addSubview(destriptionCollectionView)
        
    }
    
    func setupConstraints(){
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        headerView.snp.makeConstraints { make in
            make.width.equalTo(self)
            make.height.equalTo(250)
        }
        contentView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.width.height.equalTo(self.safeAreaLayoutGuide)
        }

        labelStackView.snp.makeConstraints { make in
            make.top.equalTo(self).offset(100)
            make.centerX.equalTo(self.safeAreaLayoutGuide)
        }
//        mainCollectionView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//        hourlyCollectionView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//        tenDayForcast.snp.makeConstraints { make in
//            make.leading.equalTo(self.safeAreaLayoutGuide).offset(18)
//            make.centerX.equalTo(self.safeAreaLayoutGuide)
//            make.top.equalTo(contentView.snp.top).offset(20)
//            make.height.equalTo(150)
//        }
//        temperature.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
//        destributionLabel.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
        
    }
    
}

//extension AddWeatherView:UICollectionViewDataSource{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//        return cell
//    }
//    
//    
//}

extension AddWeatherView{
    enum AddSection:Int, CaseIterable{
        case header = 0, hourlyForcast, tenDayForcast, temp, destription, buttom
    }

}
