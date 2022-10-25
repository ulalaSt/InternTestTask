//
//  Company.swift
//  InternTestTask
//
//  Created by Ulan Seitkali on 25.10.2022.
//

import Foundation

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
