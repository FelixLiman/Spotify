//
//  PlaylistListCell.swift
//  Spotify
//
//  Created by Felix Liman on 06/12/24.
//

import UIKit
import SnapKit

final class PlaylistListCell: UICollectionViewCell {
    
    static let identifier: String = "PlaylistListCellIdentifier"
    
    lazy var coverImg = UIImageView().parent(view: self)
    lazy var titleLbl = UILabel().parent(view: self)
    lazy var descriptionLbl = UILabel().parent(view: self)
    
    var model: PlaylistModel? {
        didSet {
            coverImg.setImage(string: model?.songs.first?.artworkUrl)
            titleLbl.text = model?.title
            descriptionLbl.text = "Playlist • \(model?.songs.count ?? 0) songs"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        setupConstraints()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        coverImg.image = UIImage(systemName: "music.note")?.withRenderingMode(.alwaysTemplate)
        titleLbl.text = nil
        descriptionLbl.text = nil
    }
    
    private func setupViews() {
        coverImg.style {
            $0.image = UIImage(systemName: "music.note")?.withRenderingMode(.alwaysTemplate)
            $0.tintColor = .systemGray2
            $0.contentMode = .scaleAspectFit
            $0.backgroundColor = .systemGray4
            $0.clipsToBounds = true
        }
        
        titleLbl.style {
            $0.textColor = .label
            $0.textAlignment = .left
            $0.font = .systemFont(ofSize: 15, weight: .semibold)
            $0.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        }
        
        descriptionLbl.style {
            $0.textColor = .systemGray
            $0.textAlignment = .left
            $0.font = .systemFont(ofSize: 13)
            $0.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        }
    }
    
    private func setupConstraints() {
        coverImg.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.width.equalTo(snp.height)
        }
        
        titleLbl.snp.makeConstraints { make in
            make.leading.equalTo(coverImg.snp.trailing).offset(12).priority(.high)
            make.trailing.equalToSuperview().inset(12)
            make.bottom.equalTo(coverImg.snp.centerY).inset(4)
        }
        
        descriptionLbl.snp.makeConstraints { make in
            make.top.equalTo(coverImg.snp.centerY).offset(4)
            make.leading.equalTo(coverImg.snp.trailing).offset(12).priority(.high)
            make.trailing.equalToSuperview().inset(12)
        }
    }
}
