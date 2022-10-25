//
//  EmployeeTableViewCell.swift
//  InternTestTask
//
//  Created by Ulan Seitkali on 22.10.2022.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell, ConfigurableCell {
    private let containterView: UIView = {
        let containterView = UIView()
        containterView.backgroundColor = Colors.graySky
        containterView.layer.cornerRadius = 25
        containterView.clipsToBounds = true
        containterView.translatesAutoresizingMaskIntoConstraints = false
        return containterView
    }()

    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = Colors.outerSpace
        nameLabel.font = .systemFont(ofSize: 24, weight: .regular)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.sizeToFit()
        return nameLabel
    }()
    private let circle: UIView = {
        let circle = UIView()
        circle.backgroundColor = Colors.haleNavy
        circle.clipsToBounds = true
        circle.translatesAutoresizingMaskIntoConstraints = false
        return circle
    }()
    private let nameFirstLetter: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor.white
        nameLabel.font = .systemFont(ofSize: 32, weight: .regular)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.sizeToFit()
        return nameLabel
    }()
    private let phoneLabel: UILabel = {
        let phoneLabel = UILabel()
        phoneLabel.textColor = Colors.outerSpace
        phoneLabel.font = .systemFont(ofSize: 15, weight: .regular)
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.sizeToFit()
        return phoneLabel
    }()
    private let skillsTextLabel: UILabel = {
        let skillsLabel = UILabel()
        skillsLabel.textColor = Colors.haleNavy
        skillsLabel.text = "Skills:"
        skillsLabel.translatesAutoresizingMaskIntoConstraints = false
        return skillsLabel
    }()
    private let skillsLabel: UILabel = {
        let skillsLabel = UILabel()
        skillsLabel.textColor = Colors.courtLandBlue
        skillsLabel.translatesAutoresizingMaskIntoConstraints = false
        skillsLabel.numberOfLines = 0
        return skillsLabel
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func layout() {
        contentView.addSubview(containterView)
        NSLayoutConstraint.activate([
            containterView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            containterView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            containterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            containterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
        containterView.addSubview(circle)
        NSLayoutConstraint.activate([
            circle.topAnchor.constraint(equalTo: containterView.topAnchor, constant: 10),
            circle.leadingAnchor.constraint(equalTo: containterView.leadingAnchor, constant: 10),
            circle.widthAnchor.constraint(equalToConstant: Constants.iconSize),
            circle.heightAnchor.constraint(equalToConstant: Constants.iconSize),
        ])
        containterView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: circle.trailingAnchor, constant: 16),
            nameLabel.centerYAnchor.constraint(equalTo: circle.centerYAnchor),
        ])
        containterView.addSubview(phoneLabel)
        NSLayoutConstraint.activate([
            phoneLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 7),
            phoneLabel.bottomAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            phoneLabel.trailingAnchor.constraint(lessThanOrEqualTo: containterView.trailingAnchor, constant: -10)
        ])
        circle.addSubview(nameFirstLetter)
        circle.layer.cornerRadius = Constants.iconSize/2
        NSLayoutConstraint.activate([
            nameFirstLetter.centerXAnchor.constraint(equalTo: circle.centerXAnchor),
            nameFirstLetter.centerYAnchor.constraint(equalTo: circle.centerYAnchor),
        ])
        containterView.addSubview(skillsTextLabel)
        NSLayoutConstraint.activate([
            skillsTextLabel.topAnchor.constraint(equalTo: circle.bottomAnchor, constant: 10),
            skillsTextLabel.leadingAnchor.constraint(equalTo: containterView.leadingAnchor, constant: 10)
        ])
        containterView.addSubview(skillsLabel)
        NSLayoutConstraint.activate([
            skillsLabel.topAnchor.constraint(equalTo: skillsTextLabel.topAnchor),
            skillsLabel.bottomAnchor.constraint(equalTo: containterView.bottomAnchor, constant: -10),
            skillsLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            skillsLabel.trailingAnchor.constraint(equalTo: containterView.trailingAnchor, constant: -10)
        ])
    }
    func configure(data: Employee) {
        self.nameLabel.text = data.name
        self.nameFirstLetter.text = data.name.first?.uppercased()
        self.phoneLabel.text = "(\(data.phone_number))"
        self.skillsLabel.text = data.skills.joined(separator: ", ")
    }
}

extension EmployeeTableViewCell {
    struct Constants {
        static let iconSize: CGFloat = 50
    }
}
