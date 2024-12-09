//
//  AppButton.swift
//  Spotify
//
//  Created by Felix Liman on 08/12/24.
//

import UIKit

final class AppButton: UIButton {
    
    var onTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addTarget(self, action: #selector(onTappedSelector), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func onTappedSelector() {
        onTapped?()
    }
}
