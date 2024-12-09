//
//  RecentSearchHeaderView.swift
//  Spotify
//
//  Created by Felix Liman on 09/12/24.
//

import UIKit
import SnapKit

final class RecentSearchHeaderView: UICollectionReusableView {
    
    static let identifier: String = "RecentSearchHeaderViewIdentifier"
    
    lazy var titleLbl = UILabel().parent(view: self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        titleLbl.style {
            $0.text = "Recent searches"
            $0.textColor = .label
            $0.textAlignment = .left
            $0.font = .systemFont(ofSize: 16, weight: .semibold)
        }
    }
    
    private func setupConstraints() {
        titleLbl.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(16)
        }
    }
}
