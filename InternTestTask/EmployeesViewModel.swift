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
        companyState = .isLoading(companyState.value)
        service.loadCompanyData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let company):
                self.companyState = .loaded(company)
            case .failure(let error):
                self.companyState = .failed(self.companyState.value, error)
            }
            completion()
        }
    }
}
