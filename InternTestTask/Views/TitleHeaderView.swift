//
//  TitleHeaderView.swift
//  InternTestTask
//
//  Created by Ulan Seitkali on 24.10.2022.
//

import UIKit

class TitleHeaderView: UIView {
    private let containterView: UIView = {
        let containterView = UIView()
        containterView.backgroundColor = Colors.littleFalls
        containterView.clipsToBounds = true
        containterView.layer.cornerRadius = 30
        containterView.translatesAutoresizingMaskIntoConstraints = false
        return containterView
    }()

    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Employees"
        titleLabel.textColor = Colors.haleNavy
        titleLabel.font = .systemFont(ofSize: 32, weight: .medium)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    private let companyLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = Colors.outerSpace
        titleLabel.font = .systemFont(ofSize: 20, weight: .medium)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    init(companyName: String?) {
        super.init(frame: .zero)
        self.companyLabel.text = companyName
        layout()
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero
        layer.shadowRadius = 5
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(containterView)
        NSLayoutConstraint.activate([
            containterView.topAnchor.constraint(equalTo: topAnchor),
            containterView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containterView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            containterView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
        ])
        containterView.addSubview(titleLabel)
        containterView.addSubview(companyLabel)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: containterView.leadingAnchor, constant: 25),
            titleLabel.trailingAnchor.constraint(equalTo: containterView.trailingAnchor, constant: -25),
            titleLabel.topAnchor.constraint(equalTo: containterView.topAnchor, constant: 25),
        ])
        NSLayoutConstraint.activate([
            companyLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            companyLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            companyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            companyLabel.bottomAnchor.constraint(equalTo: containterView.bottomAnchor, constant: -25),
        ])
    }
}
