//
//  EmployeeViewModel.swift
//  InternTestTask
//
//  Created by Ulan Seitkali on 22.10.2022.
//

import Foundation

class EmployeesViewModel {
    private let service: EmployeesService
    var companyState: Loadable<Company>
    
    init(service: EmployeesService, companyState: Loadable<Company> = .notRequested) {
        self.service = service
        self.companyState = companyState
    }
    
    func loadCompanyData(completion: @escaping () -> Void) {
        if let company = service.getCachedCompanyData() {
            companyState = .isLoading(company.sorted())
        } else {
            companyState.setIsLoading()
        }
        service.loadCompanyData { [weak self] result in
            switch result {
            case .success(let company):
                self?.companyState = .loaded(company.sorted())
            case .failure(let error):
                self?.companyState.setFailed(error: error)
            }
            completion()
        }
    }
}
