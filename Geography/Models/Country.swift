//
//  Country.swift
//  Geography
//
//  Created by Kevin Dieu on 10/18/22.
//

import Foundation

struct Country: Codable {
    
    var capital: String?
    var code: String?
    var currency: Currency?
    var flag: String?
    var language: Language?
    var name: String?
    var region: String?

    struct Currency: Codable {
        var code: String?
        var name: String?
        var symbol: String?
    }
    
    struct Language: Codable {
        var code: String?
        var name: String?
    }
}
