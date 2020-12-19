//
//  virusData.swift
//  CovidApp
//
//  Created by Mac2 on 15/12/20.
//  Copyright © 2020 Mac2. All rights reserved.
//

import Foundation
struct virusData: Codable {
    let country: String
    let cases: Int
    let deaths: Int
    let recovered: Int
    let population: Int
    let countryInfo: countryInfo
    
}
struct countryInfo: Codable {
    let flag: String
}
