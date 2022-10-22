//
//  EmployeeTableViewCell.swift
//  InternTestTask
//
//  Created by Ulan Seitkali on 22.10.2022.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        return nameLabel
    }()
    private let phoneLabel: UILabel = {
        let phoneLabel = UILabel()
        return phoneLabel
    }()
    private let skillsLabel: UILabel = {
        let phoneLabel = UILabel()
        return phoneLabel
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func layout() {
        
    }
}
