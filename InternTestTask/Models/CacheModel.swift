//
//  Models.swift
//  InternTestTask
//
//  Created by Ulan Seitkali on 22.10.2022.
//

import Foundation

struct CacheModel<T: Codable>: Codable {
    var value: T
    var lastCacheDate: Date = Date()
}
