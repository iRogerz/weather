//
//  TimeIntervalExtension.swift
//  weather
//
//  Created by 曾子庭 on 2022/5/30.
//

import Foundation

extension TimeInterval{
    
    private var hours:Int {
        return (Int(self) / 3600) % 100 % 24
    }
    
    private var minutes:Int {
        return (Int(self) / 60) % 60
    }
    
    private var seconds: Int{
        return Int(self) % 60
    }
    
    var stringTime: String{
        if minutes < 10{
            return  "\(hours):0\(minutes)"
        }else{
            return "\(hours):\(minutes)"
        }
    }
}
