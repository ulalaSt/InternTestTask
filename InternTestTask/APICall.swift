//
//  APICall.swift
//  InternTestTask
//
//  Created by Ulan Seitkali on 23.10.2022.
//

import Foundation

protocol APICall {
    var path: String { get }
    var method: String { get }
    var headers: [String: String]? { get }
    func body() throws -> Data?
}

extension APICall {
    func urlRequest(baseURL: String) throws -> URLRequest {
        guard let url = URL(string: baseURL + path) else {
            throw NetworkError.invalidRequest
        }
        var request = URLRequest(url: url)
//        request.httpBody = try body()
//        request.httpMethod = method
//        request.allHTTPHeaderFields = headers
        return request
    }
}
