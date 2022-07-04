//
//  TimeIntervalExtension.swift
//  weather
//
//  Created by 曾子庭 on 2022/5/30.
//

import Foundation



extension TimeInterval{
    
    func time(format:String) -> String{
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }

}
