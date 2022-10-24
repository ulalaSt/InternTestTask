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
    
    func sorted() -> Company {
        return Company(
            name: name,
            employees: employees.sorted()
        )
    }
}

struct Employee: Codable, Comparable {
    let name: String
    let phone_number: String
    let skills: [String]
    
    static func == (lhs: Employee, rhs: Employee) -> Bool {
        return lhs.name == rhs.name
    }
    
    static func < (lhs: Employee, rhs: Employee) -> Bool {
        return lhs.name < rhs.name
    }
}

struct CompanyCacheModel: Codable {
    var company: Company
    var lastCacheDate: Date
}
