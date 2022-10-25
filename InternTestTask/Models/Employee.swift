//
//  Employee.swift
//  InternTestTask
//
//  Created by Ulan Seitkali on 25.10.2022.
//

import Foundation

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
