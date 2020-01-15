//
//  DataDetails.swift
//  GCD Practice
//
//  Created by POYEH on 2020/1/14.
//  Copyright © 2020 POYEH. All rights reserved.
//

import Foundation

struct DataDetails: Codable {
    let result: Details
}

struct Details: Codable {
    let limit: Int
    let offset: Int
    let count: Int
    let sort: String
    let results: [Results]
}

struct Results: Codable {
    let functions: String
    let area: String
    let no: String
    let direction: String
    let speedLimit: String
    let location: String
    let id: Int
    let road: String
    
    enum CodingKeys: String, CodingKey {
        case functions
        case area
        case no
        case direction
        case speedLimit = "speed_limit"
        case location
        case id = "_id"
        case road
    }
}
