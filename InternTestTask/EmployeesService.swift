//
//  EmployeeService.swift
//  InternTestTask
//
//  Created by Ulan Seitkali on 22.10.2022.
//

import Foundation

class EmployeesService {
    private var session: URLSession
    private var baseURL: String
    private var networkMonitor: NetworkMonitor
    
    init(networkMonitor: NetworkMonitor, baseURL: String, session: URLSession = .shared){
        self.networkMonitor = networkMonitor
        self.baseURL = baseURL
        self.session = session
    }
    
    func loadCompanyData(completion: @escaping (Loadable<Company>) -> Void) {
        if !networkMonitor.isConnected {
            completion(.failed(.noConnection))
            return
        }
        guard let request = try? API.loadCompanyData.urlRequest(baseURL: baseURL) else {
            completion(.failed(.invalidRequest))
            return
        }
        session.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failed(.unexpectedResponse))
                return
            }
            guard let response = try? JSONDecoder().decode(CompanyResponse.self, from: data) else {
                completion(.failed(.unexpectedResponse))
                return
            }
            completion(.loaded(response.company))
            return
        }.resume()
    }
}

extension EmployeesService {
    enum API {
        case loadCompanyData
    }
}

extension EmployeesService.API: APICall {
    var path: String {
        switch self {
        case .loadCompanyData:
            return "/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
        }
    }
    
    var method: String {
        switch self {
        case .loadCompanyData:
            return "GET"
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .loadCompanyData:
            return nil
        }
    }
    
    func body() throws -> Data? {
        switch self {
        case .loadCompanyData:
            return nil
        }
    }
}


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

