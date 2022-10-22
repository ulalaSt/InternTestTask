//
//  EmployeeViewController.swift
//  InternTestTask
//
//  Created by Ulan Seitkali on 22.10.2022.
//

import UIKit

class EmployeesViewController: UIViewController {
    private let viewModel: EmployeesViewModel
    private let networkMonitor: NetworkMonitor
    
    init(viewModel: EmployeesViewModel, networkMonitor: NetworkMonitor) {
        self.viewModel = viewModel
        self.networkMonitor = networkMonitor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
