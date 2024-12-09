//
//  PlaylistHeaderView.swift
//  Spotify
//
//  Created by Felix Liman on 08/12/24.
//

import UIKit
import SnapKit

final class PlaylistHeaderView: UICollectionReusableView {
    
    static let identifier: String = "PlaylistHeaderViewIdentifier"
    
    lazy var sortBtn = UIButton().parent(view: self)
    lazy var sortTypeLbl = UILabel().parent(view: self)
    lazy var changeStyleBtn = AppButton().parent(view: self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        sortBtn.style {
            $0.setImage(UIImage(systemName: "arrow.up.arrow.down"), for: .normal)
            $0.tintColor = .label
        }
        
        sortTypeLbl.style {
            $0.text = "Most recent"
            $0.textColor = .label
            $0.textAlignment = .left
            $0.font = .systemFont(ofSize: 12)
        }
        
        changeStyleBtn.style {
            $0.setImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
            $0.tintColor = .label
        }
    }
    
    private func setupConstraints() {
        sortBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview().inset(16)
            make.size.equalTo(24)
        }
        
        changeStyleBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(16)
            make.size.equalTo(24)
        }
        
        sortTypeLbl.snp.makeConstraints { make in
            make.centerY.equalTo(sortBtn)
            make.leading.equalTo(sortBtn.snp.trailing).offset(12)
            make.trailing.equalTo(changeStyleBtn.snp.leading).inset(12).priority(.high)
        }
    }
}
