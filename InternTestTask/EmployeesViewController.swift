//
//  EmployeeViewController.swift
//  InternTestTask
//
//  Created by Ulan Seitkali on 22.10.2022.
//

import UIKit

class EmployeesViewController: UIViewController {
    private let viewModel: EmployeesViewModel
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(EmployeeTableViewCell.self, forCellReuseIdentifier: EmployeeTableViewCell.reuseIdentifier)
        return tableView
    }()
        
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlDidPull), for: .valueChanged)
        refreshControl.tintColor = .black
        return refreshControl
    }()

    init(viewModel: EmployeesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.refreshControl = refreshControl
        layout()
        reloadData()
    }
    
    @objc private func refreshControlDidPull() {
        reloadData()
    }
    
    private func layout() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    private func reloadData() {
        tableView.refreshControl?.beginRefreshing()
        viewModel.loadCompanyData { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.tableView.refreshControl?.endRefreshing()
            }
        }
    }
}

extension EmployeesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let error = viewModel.companyState.error else {
            return nil
        }
        let errorView = ErrorHeaderView(error: error)
        return errorView
    }
}

extension EmployeesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = viewModel.companyState.value?.employees.count else {
            return 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeTableViewCell.reuseIdentifier, for: indexPath)
        guard let employees = viewModel.companyState.value?.employees, let cell = cell as? EmployeeTableViewCell else {
            return .init()
        }
        cell.configure(data: employees[indexPath.row])
        return cell
    }
}
