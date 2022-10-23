//
//  EmployeeViewModel.swift
//  InternTestTask
//
//  Created by Ulan Seitkali on 22.10.2022.
//

import Foundation

class EmployeesViewModel {
    let service: EmployeesService
    var companyState: Loadable<Company> = .notRequested
    
    init(service: EmployeesService) {
        self.service = service
    }
    
    func loadCompanyData(completion: @escaping () -> Void) {
        companyState = .isLoading
        service.loadCompanyData { [weak self] companyState in
            self?.companyState = companyState
            print(companyState)
            completion()
        }
    }
}
