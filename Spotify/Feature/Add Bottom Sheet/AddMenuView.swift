//
//  AddMenuView.swift
//  Spotify
//
//  Created by Felix Liman on 09/12/24.
//

import UIKit
import SnapKit

final class AddMenuView: UIView {
    
    lazy var iconImg = UIImageView().parent(view: self)
    lazy var titleLbl = UILabel().parent(view: self)
    lazy var captionLbl = UILabel().parent(view: self)
    
    var onTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        setupConstraints()
        setupViews()
        setupGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func onTappedSelector() {
        onTapped?()
    }
    
    private func setupGestures() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTappedSelector)))
    }
    
    private func setupViews() {
        iconImg.style {
            $0.tintColor = .systemGray
            $0.contentMode = .scaleAspectFit
            $0.backgroundColor = .clear
            $0.clipsToBounds = true
        }
        
        titleLbl.style {
            $0.textColor = .white
            $0.textAlignment = .left
            $0.numberOfLines = 1
            $0.font = .systemFont(ofSize: 18, weight: .semibold)
        }
        
        captionLbl.style {
            $0.textColor = .systemGray
            $0.textAlignment = .left
            $0.numberOfLines = 1
            $0.font = .systemFont(ofSize: 13, weight: .semibold)
        }
    }
    
    private func setupConstraints() {
        iconImg.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.size.equalTo(24)
            make.centerY.equalToSuperview()
        }
        
        titleLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(iconImg.snp.trailing).offset(16)
            make.trailing.lessThanOrEqualToSuperview().inset(16).priority(.high)
        }
        
        captionLbl.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom)
            make.leading.equalTo(iconImg.snp.trailing).offset(16)
            make.trailing.lessThanOrEqualToSuperview().inset(16).priority(.high)
            make.bottom.equalToSuperview().inset(16)
        }
        
    }
}
