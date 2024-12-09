//
//  SongListCell.swift
//  Spotify
//
//  Created by Felix Liman on 08/12/24.
//

import UIKit
import SnapKit

final class SongListCell: UICollectionViewCell {
    
    static let identifier: String = "SongListCellIdentifier"
    
    lazy var coverImg = UIImageView().parent(view: self)
    lazy var trackNameLbl = UILabel().parent(view: self)
    lazy var descriptionLbl = UILabel().parent(view: self)
    lazy var moreBtn = AppButton().parent(view: self)
    
    var model: SongModel? {
        didSet {
            coverImg.setImage(string: model?.artworkUrl)
            trackNameLbl.text = model?.trackName
            let descriptionArray = [model?.kind, model?.artistName].compactMap({ $0 })
            descriptionLbl.text = descriptionArray.joined(separator: " • ")
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.clear
        
        setupConstraints()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        coverImg.style {
            $0.image = UIImage(named: "cover")
            $0.backgroundColor = .clear
            $0.clipsToBounds = true
        }
        
        trackNameLbl.style {
            $0.textColor = .label
            $0.textAlignment = .left
            $0.numberOfLines = 1
            $0.font = .systemFont(ofSize: 15, weight: .semibold)
            $0.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        }
        
        descriptionLbl.style {
            $0.textColor = .systemGray
            $0.textAlignment = .left
            $0.numberOfLines = 1
            $0.font = .systemFont(ofSize: 13)
        }
        
        moreBtn.style {
            $0.setImage(UIImage(systemName: "ellipsis")?.rotate(radians: .pi / 2)?.withRenderingMode(.alwaysTemplate), for: .normal)
            $0.tintColor = .label
        }
    }
    
    private func setupConstraints() {
        coverImg.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.width.equalTo(snp.height)
        }
        
        moreBtn.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalTo(coverImg)
            make.size.equalTo(24)
        }
        
        trackNameLbl.snp.makeConstraints { make in
            make.leading.equalTo(coverImg.snp.trailing).offset(12)
            make.trailing.lessThanOrEqualTo(moreBtn.snp.leading).inset(-12)
            make.bottom.equalTo(coverImg.snp.centerY).inset(4)
        }
        
        descriptionLbl.snp.makeConstraints { make in
            make.top.equalTo(coverImg.snp.centerY).offset(4)
            make.leading.equalTo(coverImg.snp.trailing).offset(12)
            make.trailing.lessThanOrEqualTo(moreBtn.snp.leading).inset(-12)
        }
    }
}
