//
//  ErrorHeaderView.swift
//  InternTestTask
//
//  Created by Ulan Seitkali on 23.10.2022.
//

import UIKit

class ErrorHeaderView: UIView {
    private let containterView: UIView = {
        let containterView = UIView()
        containterView.backgroundColor = Colors.gentleGray
        containterView.layer.cornerRadius = 10
        containterView.clipsToBounds = true
        containterView.translatesAutoresizingMaskIntoConstraints = false
        return containterView
    }()

    private let errorLabel: UILabel = {
        let errorLabel = UILabel()
        errorLabel.textColor = Colors.haleNavy
        errorLabel.font = .systemFont(ofSize: 13, weight: .medium)
        errorLabel.numberOfLines = 0
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        return errorLabel
    }()
    private let errorImage: UIImageView = {
        let errorImage = UIImageView()
        errorImage.contentMode = .scaleAspectFit
        errorImage.tintColor = Colors.haleNavy
        errorImage.translatesAutoresizingMaskIntoConstraints = false
        return errorImage
    }()

    init(error: NetworkError) {
        super.init(frame: .zero)
        self.errorLabel.text = "\(error.errorDescription ?? "Something went wrong") or pull down to try again"
        switch error {
        case .noConnection:
            errorImage.image = UIImage(systemName: "icloud.slash")
        default:
            errorImage.image = UIImage(systemName: "exclamationmark.triangle")
        }
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero
        layer.shadowRadius = 5
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(containterView)
        NSLayoutConstraint.activate([
            containterView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containterView.topAnchor.constraint(equalTo: topAnchor),
            containterView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containterView.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -10),
            containterView.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 10),
        ])
        containterView.addSubview(errorImage)
        containterView.addSubview(errorLabel)
        NSLayoutConstraint.activate([
            errorImage.leadingAnchor.constraint(equalTo: containterView.leadingAnchor, constant: 10),
            errorImage.centerYAnchor.constraint(equalTo: errorLabel.centerYAnchor),
            errorImage.widthAnchor.constraint(equalToConstant: 20),
            errorImage.heightAnchor.constraint(equalToConstant: 20),
        ])
        NSLayoutConstraint.activate([
            errorLabel.leadingAnchor.constraint(equalTo: errorImage.trailingAnchor, constant: 10),
            errorLabel.topAnchor.constraint(equalTo: containterView.topAnchor, constant: 5),
            errorLabel.bottomAnchor.constraint(equalTo: containterView.bottomAnchor, constant: -5),
            errorLabel.trailingAnchor.constraint(equalTo: containterView.trailingAnchor, constant: -10),
        ])
    }
}
