//
//  UIView+Extension.swift
//  Spotify
//
//  Created by Felix Liman on 06/12/24.
//

import UIKit

extension UIView {
    @discardableResult
    func parent(view: UIView) -> Self {
        if let stackView = view as? UIStackView {
            stackView.addArrangedSubview(self)
        } else {
            view.addSubview(self)
        }
        return self
    }

    func corner(radius: CGFloat = 0) {
        layer.cornerRadius = radius
    }

    func border(color: UIColor = UIColor.clear, width: CGFloat = 0) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }

    func shadow(color: UIColor = UIColor.gray, size: CGSize = .zero, radius: CGFloat = 4, opacity: Float = 0.3) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = size
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
    }
}
