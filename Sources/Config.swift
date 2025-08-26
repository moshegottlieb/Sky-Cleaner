//
//  Config.swift
//  Sky Cleaner
//
//  Created by Moshe Gottlieb on 24.08.25.
//

import Foundation

class Config: Decodable, @unchecked Sendable {
    
    private init(){
        fatalError()
    }
    
    enum CodingKeys : String, CodingKey {
        case user
        case password
        case daysToKeep = "days-to-keep"
    }
    
    let user : String
    let password : String
    let daysToKeep : Int
    var oldest : Date {
        if let _oldest = _oldest {
            return _oldest
        }
        _oldest = Calendar.current.date(byAdding: DateComponents(day: -daysToKeep), to: Date())
        return _oldest!
    }
    private var _oldest : Date?
}


