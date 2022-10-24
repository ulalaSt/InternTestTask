//
//  EmployeeService.swift
//  InternTestTask
//
//  Created by Ulan Seitkali on 22.10.2022.
//

import Foundation

class EmployeesService {
    private var session: URLSession
    private var cacheTimeInterval: TimeInterval
    private var baseURL: String
    private var networkMonitor: NetworkMonitor
    
    
    init(networkMonitor: NetworkMonitor, baseURL: String, session: URLSession = .shared, cacheTimeInterval: TimeInterval = 60){
        self.networkMonitor = networkMonitor
        self.baseURL = baseURL
        self.cacheTimeInterval = cacheTimeInterval
        self.session = session
    }
    
    func loadCompanyData(completion: @escaping (Result<Company, NetworkError>) -> Void) {
        guard let request = try? API.loadCompanyData.urlRequest(baseURL: baseURL) else {
            completion(.failure(.invalidRequest))
            return
        }
        if let url = request.url,
           let cachedResponse = readFile(fileName: url.absoluteString.replacingOccurrences(of: "/", with: ":")) {
                completion(.success(cachedResponse.company))
        }
        if !networkMonitor.isConnected {
            completion(.failure(.noConnection))
            return
        }
        session.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(.unexpectedResponse))
                return
            }
            guard let response = try? JSONDecoder().decode(CompanyResponse.self, from: data) else {
                completion(.failure(.unexpectedResponse))
                return
            }
            let cacheModel = CompanyCacheModel(company: response.company, lastCacheDate: Date())
            print("SSS", cacheModel.lastCacheDate)
            let encoder = JSONEncoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            encoder.dateEncodingStrategy = .formatted(dateFormatter)
            if let url = request.url,
               let cacheURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first,
               let cacheData = try? encoder.encode(cacheModel) {
                do { try cacheData.write(to: cacheURL.appendingPathComponent(url.absoluteString.replacingOccurrences(of: "/", with: ":"))) } catch {}
            }
            completion(.success(response.company))
        }.resume()
    }
    func readFile(fileName: String) -> CompanyCacheModel? {
        let file = "\(fileName)"
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            do {
                let data = try Data(contentsOf: fileURL)
                print("SSS")
                let decoder = JSONDecoder()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                decoder.dateDecodingStrategy = .formatted(dateFormatter)
                let response = try decoder.decode(CompanyCacheModel.self, from: data)
                print("SSS", response.lastCacheDate)
                let interval = Date().timeIntervalSince1970 - response.lastCacheDate.timeIntervalSince1970
                if interval > cacheTimeInterval {
                    do {
                        try FileManager.default.removeItem(at: fileURL)
                    } catch {
                        print(error)
                    }
                }
                return response
            }
            catch {
                return nil
            }
        }
        return nil
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
