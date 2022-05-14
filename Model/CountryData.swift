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
    }
}
