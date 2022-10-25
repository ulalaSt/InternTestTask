//
//  SceneDelegate.swift
//  InternTestTask
//
//  Created by Ulan Seitkali on 22.10.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let networkMonitor = NetworkMonitorImpl()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        networkMonitor.startMonitoring()
        let viewController = EmployeesViewController(viewModel: createEmpoyeesViewModel())
        let navigationController = UINavigationController(rootViewController: viewController)
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigationController
        
        self.window = window
        self.window?.makeKeyAndVisible()
    }
    
    private func createEmpoyeesViewModel() -> EmployeesViewModel {
        let service = EmployeesService(networkMonitor: networkMonitor, cacheManager: createEmployeesCacheManager(), baseURL: "https://run.mocky.io")
        return EmployeesViewModel(service: service)
    }
    
    private func createEmployeesCacheManager() -> CacheManager<Company>? {
        guard let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return CacheManager<Company>(directory: directory, timeInterval: 3600)
    }
}
