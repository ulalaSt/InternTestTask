//
//  EmployeeTableViewCell.swift
//  InternTestTask
//
//  Created by Ulan Seitkali on 22.10.2022.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell, ConfigurableCell {
    private let circleSize: CGFloat = 50
    
    private let containterView: UIView = {
        let containterView = UIView()
        containterView.backgroundColor = UIColor.init(red: 220/255, green: 229/255, blue: 228/255, alpha: 1)
        containterView.layer.cornerRadius = 25
        containterView.clipsToBounds = true
        containterView.translatesAutoresizingMaskIntoConstraints = false
        return containterView
    }()

    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor.init(red: 88/255, green: 97/255, blue: 104/255, alpha: 1)
        nameLabel.font = .systemFont(ofSize: 24, weight: .regular)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.sizeToFit()
        return nameLabel
    }()
    private let circle: UIView = {
        let circle = UIView()
        circle.backgroundColor = UIColor.init(red: 68/255, green: 77/255, blue: 86/255, alpha: 1)
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
        phoneLabel.textColor = UIColor.init(red: 88/255, green: 97/255, blue: 104/255, alpha: 1)
        phoneLabel.font = .systemFont(ofSize: 15, weight: .regular)
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.sizeToFit()
        return phoneLabel
    }()
    private let skillsTextLabel: UILabel = {
        let skillsLabel = UILabel()
        skillsLabel.textColor = UIColor.init(red: 68/255, green: 77/255, blue: 86/255, alpha: 1)
        skillsLabel.text = "Skills:"
        skillsLabel.translatesAutoresizingMaskIntoConstraints = false
        return skillsLabel
    }()
    private let skillsLabel: UILabel = {
        let skillsLabel = UILabel()
        skillsLabel.textColor = UIColor.white
        skillsLabel.text = "Skills:"
        skillsLabel.translatesAutoresizingMaskIntoConstraints = false
        skillsLabel.numberOfLines = 0
//        skillsLabel.backgroundColor = UIColor.init(red: 88/255, green: 97/255, blue: 104/255, alpha: 1)
//        skillsLabel.clipsToBounds = true
//        skillsLabel.layer.cornerRadius = 10
        return skillsLabel
    }()
    private let labelHorizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .bottom
        stack.distribution = .fill
        stack.spacing = 7
        return stack
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func layout() {
        backgroundColor = .clear
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
            circle.widthAnchor.constraint(equalToConstant: 50),
            circle.heightAnchor.constraint(equalToConstant: 50),
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
        circle.layer.cornerRadius = circleSize/2
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
        print(data)
        self.nameLabel.text = data.name
        self.nameFirstLetter.text = data.name.first?.uppercased()
        self.phoneLabel.text = "(\(data.phone_number))"
        var text = ""
        for skill in data.skills {
            text.append("\(skill), \(skill), \(skill), \(skill), ")
        }
        self.skillsLabel.text = text
    }
}

extension EmployeeTableViewCell {
    struct Constants {
        static let sideInset: CGFloat = 10
        static let circleSize: CGFloat = 50
    }
}
