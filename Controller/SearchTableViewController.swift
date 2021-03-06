//
//  SearchTableViewController.swift
//  weather
//
//  Created by 曾子庭 on 2022/5/11.
//

import UIKit

class SearchTableViewController: UITableViewController {
 
    
    var allCountry = AllCountry()
    var tempCountry = [String]()
    
    var delegate:SaveWeatherDelegate?
    
    
    //MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //        tableView.overrideUserInterfaceStyle = .dark
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.snp.makeConstraints { make in
            
        }
        
        let searchController = UISearchController(searchResultsController: nil)
//        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempCountry.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = tempCountry[indexPath.row]
        cell.textLabel?.text = item
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = tempCountry[indexPath.row]
        let vc = AddWeatherViewController()
        vc.getWeather(.city(country))
        vc.delegate = self.delegate
        let addWeatherNC = UINavigationController(rootViewController: vc)
        present(addWeatherNC, animated: true, completion: nil)
//        dismiss(animated: true)
    }
}

//extension SearchTableViewController:UISearchBarDelegate{
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        if searchBar.text?.contains(",") == true{
//
//        }
//    }
//}
