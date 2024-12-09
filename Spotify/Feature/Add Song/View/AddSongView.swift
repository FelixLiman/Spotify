//
//  AddSongView.swift
//  Spotify
//
//  Created by Felix Liman on 08/12/24.
//

import UIKit
import SnapKit

final class AddSongView: UIView {
    
    lazy var searchBar = UISearchBar().parent(view: self)
    lazy var cancelBtn = AppButton().parent(view: self)
    lazy var recentCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).parent(view: self)
    lazy var resultCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).parent(view: self)
    
    lazy var recentCollectionViewLayout: UICollectionViewFlowLayout = {
        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.scrollDirection = .vertical
        collectionFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionFlowLayout.itemSize = CGSize(width: (self.frame.width - 32) , height: 52)
        collectionFlowLayout.minimumInteritemSpacing = 16
        collectionFlowLayout.minimumLineSpacing = 16
        return collectionFlowLayout
    }()
    
    lazy var resultListCollectionViewLayout: UICollectionViewFlowLayout = {
        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.scrollDirection = .vertical
        collectionFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionFlowLayout.itemSize = CGSize(width: (self.frame.width - 32) , height: 52)
        collectionFlowLayout.minimumInteritemSpacing = 16
        collectionFlowLayout.minimumLineSpacing = 16
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
    
    func updateState(state: AddSongViewState) {
        UIView.animate(withDuration: 0.4) {
            self.recentCollectionView.alpha = state == .recent ? 1 : 0
            self.resultCollectionView.alpha = state == .result ? 1 : 0
        }
    }
    
    func setupGeometry() {
        recentCollectionView.collectionViewLayout = recentCollectionViewLayout
        resultCollectionView.collectionViewLayout = resultListCollectionViewLayout
    }
    
    private func setupViews() {
        searchBar.style {
            $0.searchTextField.placeholder = "Search..."
        }
        
        cancelBtn.style {
            $0.setTitle("Cancel", for: .normal)
            $0.setTitleColor(.label, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 15)
        }
        
        recentCollectionView.style {
            $0.backgroundColor = .clear
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
            $0.register(RecentSearchHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: RecentSearchHeaderView.identifier)
            $0.register(SongListCell.self, forCellWithReuseIdentifier: SongListCell.identifier)
        }
        
        resultCollectionView.style {
            $0.backgroundColor = .clear
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
            $0.register(SongListCell.self, forCellWithReuseIdentifier: SongListCell.identifier)
            $0.alpha = 0
        }
    }
    
    private func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(8)
            make.leading.equalTo(safeAreaLayoutGuide).inset(6)
        }
        
        cancelBtn.snp.makeConstraints { make in
            make.leading.equalTo(searchBar.snp.trailing).offset(2)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(8)
            make.centerY.equalTo(searchBar)
        }
        
        cancelBtn.titleLabel?.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        recentCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(24)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalToSuperview()
        }

        resultCollectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(24)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalToSuperview()
        }
    }
}
