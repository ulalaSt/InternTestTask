//
//  Loadable.swift
//  InternTestTask
//
//  Created by Ulan Seitkali on 22.10.2022.
//

import Foundation

enum Loadable<T> {
    case notRequested
    case isLoading
    case loaded(T)
    case failed(NetworkError)
}
