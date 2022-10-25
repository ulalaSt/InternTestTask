//
//  EmployeesCachManager.swift
//  InternTestTask
//
//  Created by Ulan Seitkali on 25.10.2022.
//

import Foundation

class CacheManager<T: Codable> {
    private var directory: URL
    private var timeInterval: TimeInterval
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return dateFormatter
    }()
    
    init(directory: URL, timeInterval: TimeInterval) {
        self.directory = directory
        self.timeInterval = timeInterval
    }
    
    func readFile(fileName: String) -> T? {
        let fileURL = directory.appendingPathComponent(fileName)
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            let cacheData = try Data(contentsOf: fileURL)
            let cacheModel = try decoder.decode(CacheModel<T>.self, from: cacheData)
            let interval = Date().timeIntervalSince1970 - cacheModel.lastCacheDate.timeIntervalSince1970
            if interval > timeInterval {
                deleteFile(fileName: fileName)
                return nil
            }
            return cacheModel.value
        }
        catch {
            return nil
        }
    }
    
    func deleteFile(fileName: String) {
        let fileURL = directory.appendingPathComponent(fileName)
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch {
            print(error)
        }
    }
    
    func writeFile(with model: T, fileName: String) {
        let cacheModel = CacheModel(value: model)
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(dateFormatter)
        do {
            let cacheData = try encoder.encode(cacheModel)
            try cacheData.write(to: directory.appendingPathComponent(fileName))
        } catch {
            print(error)
        }
    }
}
