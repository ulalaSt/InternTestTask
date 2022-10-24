//
//  EmployeeViewModel.swift
//  InternTestTask
//
//  Created by Ulan Seitkali on 22.10.2022.
//

import Foundation

class EmployeesInteractor {
    let webRepository: EmployeesWebRepository
    let dbRepository: EmployeesDbRepository
    var companyState: Loadable<Company> = .notRequested
    
    init(webRepository: EmployeesWebRepository, dbRepository: EmployeesDbRepository) {
        self.webRepository = webRepository
        self.dbRepository = dbRepository
    }
    
    func loadCompanyData(completion: @escaping () -> Void) {
        companyState = .isLoading
        webRepository.loadCompanyData { [weak self] companyState in
            self?.companyState = companyState
            print(companyState)
            completion()
        }
    }
}
