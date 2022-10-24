//
//  Models.swift
//  InternTestTask
//
//  Created by Ulan Seitkali on 22.10.2022.
//

import Foundation

struct CompanyResponse: Codable {
    let company: Company
}

struct Company: Codable {
    let name: String
    let employees: [Employee]
}

struct Employee: Codable {
    let name: String
    let phone_number: String
    let skills: [String]
}

struct CompanyCacheModel: Codable {
    var company: Company
    var lastCacheDate: String
}
