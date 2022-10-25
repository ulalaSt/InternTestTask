//
//  NetworkError.swift
//  InternTestTask
//
//  Created by Ulan Seitkali on 25.10.2022.
//

import Foundation

enum NetworkError: Error {
    case noConnection
    case unexpectedResponse
    case invalidRequest
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noConnection:
            return "No Connection"
        case .unexpectedResponse:
            return "Unexpected Response"
        case .invalidRequest:
            return "Invalid Request"
        }
    }
}
