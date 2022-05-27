//
//  CountryData.swift
//  weather
//
//  Created by 曾子庭 on 2022/5/13.
//

import Foundation



struct CountryData:Decodable{
    var data:[Country]
}

struct Country:Decodable{
    var iso2:String
    var country:String
    var cities:[String]
}



class AllCountry{
    
    var countrys =  [String]()
    
    func append(_ country:String){
        countrys.append(country)
        
        if country.lowercased() == "taiwan" {
            print("Find taiwan")
        }
    }
    
    func getCountry(){
        let address = "https://countriesnow.space/api/v0.1/countries"
        if let url = URL(string: address) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error{
                    print("Error \(error.localizedDescription)")
                }else if let response = response as? HTTPURLResponse, let data = data{
                    
                    print("Status code \(response.statusCode)")
                    
                    let decoder = JSONDecoder()
                    if let data = try? decoder.decode(CountryData.self, from: data){
                        for country in data.data.sorted(by: {$0.country < $1.country}) {
                            self.append(country.country)
                        }
                    }
                }
            }.resume()
        }
    }
}
