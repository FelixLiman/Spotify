//
//  AddBottomSheetView.swift
//  Spotify
//
//  Created by Felix Liman on 09/12/24.
//

import UIKit
import SnapKit

final class AddBottomSheetView: UIView {
    
    lazy var dialogView = UIView().parent(view: self)
    
    lazy var addPlaylistBtn = AddMenuView().parent(view: dialogView)
    
    var onTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        isOpaque = false
        backgroundColor = .black.withAlphaComponent(0.6)
        
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
        dialogView.style {
            $0.backgroundColor = AppColor.darkGray
            $0.corner(radius: 16)
        }
        
        addPlaylistBtn.style {
            $0.iconImg.image = UIImage(systemName: "music.note.list")?.withRenderingMode(.alwaysTemplate)
            $0.titleLbl.text = "Playlist"
            $0.captionLbl.text = "Create a playlist with a song"
        }
    }
    
    private func setupConstraints() {
        dialogView.snp.makeConstraints { make in
            make.top.greaterThanOrEqualToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(16)
        }
        
        addPlaylistBtn.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().priority(.high)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(32)
        }
    }
}
