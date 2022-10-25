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
    private var cacheManager: CacheManager<Company>?
    
    init(networkMonitor: NetworkMonitor, cacheManager: CacheManager<Company>?, baseURL: String, session: URLSession = .shared){
        self.networkMonitor = networkMonitor
        self.baseURL = baseURL
        self.cacheManager = cacheManager
        self.session = session
    }
    
    func getCachedCompanyData() -> Company? {
        return cacheManager?.readFile(fileName: API.loadCompanyData.cachedResponseFileName)
    }
    
    func loadCompanyData(completion: @escaping (Result<Company, NetworkError>) -> Void) {
        guard let request = try? API.loadCompanyData.urlRequest(baseURL: baseURL) else {
            completion(.failure(.invalidRequest))
            return
        }
        if !networkMonitor.isConnected {
            completion(.failure(.noConnection))
            return
        }
        session.dataTask(with: request) { [weak self] data, _, error in
            guard let data = data, error == nil, let response = try? JSONDecoder().decode(CompanyResponse.self, from: data) else {
                completion(.failure(.unexpectedResponse))
                return
            }
            self?.cacheManager?.writeFile(with: response.company, fileName: API.loadCompanyData.cachedResponseFileName)
            completion(.success(response.company))
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

extension EmployeesService.API {
    var cachedResponseFileName: String {
        switch self {
        case .loadCompanyData:
            return self.method + self.path.replacingOccurrences(of: "/", with: ":")
        }
    }
}
