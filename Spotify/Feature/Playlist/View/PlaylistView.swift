//
//  PlaylistView.swift
//  Spotify
//
//  Created by Felix Liman on 06/12/24.
//

import UIKit
import SnapKit

final class PlaylistView: UIView {
    
    lazy var avatarImage = UIImageView().parent(view: self)
    lazy var titleLbl = UILabel().parent(view: self)
    lazy var addBtn = AppButton().parent(view: self)
    
    lazy var playlistView = UIView().parent(view: self)
    lazy var playlistTitleLbl = UILabel().parent(view: playlistView)
    
    lazy var changeBtn = AppButton().parent(view: self)
    
    lazy var playlistCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).parent(view: self)
    
    lazy var listCollectionViewLayout: UICollectionViewFlowLayout = {
        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.scrollDirection = .vertical
        collectionFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionFlowLayout.itemSize = CGSize(width: (self.frame.width - 32) , height: 84)
        collectionFlowLayout.minimumInteritemSpacing = 16
        collectionFlowLayout.minimumLineSpacing = 16
        return collectionFlowLayout
    }()
    
    lazy var gridCollectionViewLayout: UICollectionViewFlowLayout = {
        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.scrollDirection = .vertical
        collectionFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionFlowLayout.itemSize = CGSize(width: (self.frame.width - 48) / 2 , height: (self.frame.width - 48) / 2 + 72)
        collectionFlowLayout.minimumInteritemSpacing = 16
        collectionFlowLayout.minimumLineSpacing = 32
        return collectionFlowLayout
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        
        setupConstraints()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupGeometry() {
        avatarImage.style {
            $0.corner(radius: $0.frame.height / 2)
        }
        
        playlistView.style {
            $0.corner(radius: $0.frame.height / 2)
        }
        
        playlistCollectionView.collectionViewLayout = listCollectionViewLayout
    }
    
    func setupLayers() {
        playlistView.style {
            $0.border(color: .label, width: 1)
        }
    }
    
    func transitionLayout(to viewType: PlaylistViewType) {
        playlistCollectionView.reloadSections(IndexSet(integer: 0))
        switch viewType {
        case .list:
            changeBtn.setImage(UIImage(systemName: "square.grid.2x2"), for: .normal)
            playlistCollectionView.setCollectionViewLayout(listCollectionViewLayout, animated: true)
        case .grid:
            changeBtn.setImage(UIImage(systemName: "list.bullet"), for: .normal)
            playlistCollectionView.setCollectionViewLayout(gridCollectionViewLayout, animated: true)
        }
        playlistCollectionView.collectionViewLayout.invalidateLayout()
        playlistCollectionView.setContentOffset(.zero, animated: true)
    }
    
    private func setupViews() {
        avatarImage.style {
            $0.backgroundColor = AppColor.mainGreen
            $0.clipsToBounds = true
        }
        
        titleLbl.style {
            $0.text = "Your Library"
            $0.textColor = .label
            $0.font = .systemFont(ofSize: 24, weight: .semibold)
        }
        
        addBtn.style {
            $0.setImage(UIImage(systemName: "plus"), for: .normal)
            $0.tintColor = .label
        }
        
        playlistView.style {
            $0.backgroundColor = .clear
        }
        
        playlistTitleLbl.style {
            $0.text = "Playlists"
            $0.textColor = .label
            $0.textAlignment = .center
            $0.font = .systemFont(ofSize: 12)
        }
        
        playlistCollectionView.style {
            $0.backgroundColor = .clear
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
            $0.register(PlaylistHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PlaylistHeaderView.identifier)
            $0.register(PlaylistGridCell.self, forCellWithReuseIdentifier: PlaylistGridCell.identifier)
            $0.register(PlaylistListCell.self, forCellWithReuseIdentifier: PlaylistListCell.identifier)
        }
    }
    
    private func setupConstraints() {
        avatarImage.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(16)
            make.leading.equalTo(safeAreaLayoutGuide).inset(16)
            make.size.equalTo(36)
        }
        
        titleLbl.snp.makeConstraints { make in
            make.centerY.equalTo(avatarImage)
            make.leading.equalTo(avatarImage.snp.trailing).offset(8)
        }
        
        addBtn.snp.makeConstraints { make in
            make.centerY.equalTo(avatarImage)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.size.equalTo(24)
        }
        
        playlistView.snp.makeConstraints { make in
            make.top.equalTo(avatarImage.snp.bottom).offset(32)
            make.leading.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        playlistTitleLbl.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        playlistCollectionView.snp.makeConstraints { make in
            make.top.equalTo(playlistView.snp.bottom).offset(16)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalToSuperview()
        }
    }
}
