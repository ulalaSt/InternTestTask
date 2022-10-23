//
//  ConfigurableCell.swift
//  InternTestTask
//
//  Created by Ulan Seitkali on 23.10.2022.
//

import Foundation

protocol ConfigurableCell {
    associatedtype DataType

    static var reuseIdentifier: String { get }

    func configure(data: DataType)
}

extension ConfigurableCell {
    static var reuseIdentifier: String { return String(describing: Self.self) }
}
