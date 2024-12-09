//
//  NewPlaylistView.swift
//  Spotify
//
//  Created by Felix Liman on 08/12/24.
//

import UIKit
import SnapKit

final class NewPlaylistView: UIView {
    
    lazy var guideLbl = UILabel().parent(view: self)
    lazy var titleTF = UITextField().parent(view: self)
    lazy var titleLine = UIView().parent(view: self)
    lazy var createBtn = AppButton().parent(view: self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .darkGray
        keyboardLayoutGuide.followsUndockedKeyboard = true
        setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        setupConstraints()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupGeometry() {
        createBtn.style {
            $0.corner(radius: $0.frame.height / 2)
        }
    }
    
    private func setupViews() {
        guideLbl.style {
            $0.text = "Name your playlist."
            $0.textColor = .white
            $0.textAlignment = .center
            $0.font = .systemFont(ofSize: 24)
            $0.setContentCompressionResistancePriority(.required, for: .vertical)
        }
        
        titleTF.style {
            $0.textColor = .white
            $0.font = .systemFont(ofSize: 32)
            $0.textAlignment = .center
            $0.setContentCompressionResistancePriority(.required, for: .vertical)
        }
        
        titleLine.style {
            $0.backgroundColor = .white
            $0.setContentCompressionResistancePriority(.required, for: .vertical)
        }
        
        createBtn.style {
            $0.setTitle("Create", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.backgroundColor = AppColor.mainGreen
            $0.setContentCompressionResistancePriority(.required, for: .vertical)
            $0.titleLabel?.setContentCompressionResistancePriority(.required, for: .vertical)
        }
    }
    
    private func setupConstraints() {
        titleTF.snp.makeConstraints { make in
            make.center.equalToSuperview().priority(.low)
            make.leading.trailing.equalToSuperview().inset(36)
        }
        
        titleLine.snp.makeConstraints { make in
            make.top.equalTo(titleTF.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(36)
            make.height.equalTo(1)
        }
        
        guideLbl.snp.makeConstraints { make in
            make.top.greaterThanOrEqualToSuperview().offset(48)
            make.leading.trailing.equalToSuperview().inset(36)
            make.bottom.equalTo(titleTF.snp.top).inset(-84)
        }
        
        createBtn.snp.makeConstraints { make in
            make.top.equalTo(titleLine.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.bottom.lessThanOrEqualTo(keyboardLayoutGuide.snp.top).inset(-48).priority(.high)
        }
        
        createBtn.titleLabel?.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(16)
            make.leading.trailing.equalToSuperview().inset(32)
        }
    }
}
