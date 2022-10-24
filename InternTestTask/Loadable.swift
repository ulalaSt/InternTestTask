//
//  Loadable.swift
//  InternTestTask
//
//  Created by Ulan Seitkali on 22.10.2022.
//

import Foundation

enum Loadable<T> {
    case notRequested
    case isLoading(T?)
    case loaded(T)
    case failed(T?, NetworkError)
    
    var value: T? {
        switch self {
        case let .loaded(value): return value
        case let .isLoading(last): return last
        case let .failed(last, _): return last
        default: return nil
        }
    }
    var error: NetworkError? {
        switch self {
        case let .failed(_, error): return error
        default: return nil
        }
    }
}
