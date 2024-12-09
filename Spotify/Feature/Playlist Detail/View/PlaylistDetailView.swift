//
//  PlaylistDetailView.swift
//  Spotify
//
//  Created by Felix Liman on 08/12/24.
//

import UIKit
import SnapKit

final class PlaylistDetailView: UIView {
    lazy var backgroundView = UIView().parent(view: self)
    
    lazy var backBtn = AppButton().parent(view: self)
    lazy var addBtn = AppButton().parent(view: self)
    
    lazy var titleLbl = UILabel().parent(view: self)
    lazy var songsLbl = UILabel().parent(view: self)
    
    lazy var songsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout()).parent(view: self)
    
    lazy var listCollectionViewLayout: UICollectionViewFlowLayout = {
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
    
    func setupGeometry() {
        songsCollectionView.collectionViewLayout = listCollectionViewLayout
    }
    
    func setupLayers() {
        backgroundView.style {
            let colorTop = UIColor.init(hexa: 0x352295).cgColor
            let colorBottom = UIColor.systemBackground.cgColor

            let gradient = CAGradientLayer()
            gradient.frame = $0.bounds
            gradient.colors = [colorTop, colorBottom, colorBottom]
            gradient.locations = [0.0, 0.3, 1.0]
            gradient.masksToBounds = true
            
            $0.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
            $0.layer.insertSublayer(gradient, at: 0)
        }
    }
    
    private func setupViews() {
        backBtn.style {
            $0.setImage(UIImage(systemName: "arrow.left"), for: .normal)
            $0.tintColor = .label
        }
        
        addBtn.style {
            $0.setImage(UIImage(systemName: "plus"), for: .normal)
            $0.tintColor = .label
        }
        
        titleLbl.style {
            $0.textColor = .label
            $0.font = .systemFont(ofSize: 20, weight: .semibold)
        }
        
        songsLbl.style {
            $0.textColor = .systemGray
            $0.font = .systemFont(ofSize: 12, weight: .semibold)
        }
        
        songsCollectionView.style {
            $0.backgroundColor = .clear
            $0.showsHorizontalScrollIndicator = false
            $0.showsVerticalScrollIndicator = false
            $0.register(SongListCell.self, forCellWithReuseIdentifier: SongListCell.identifier)
        }
    }
    
    private func setupConstraints() {
        backgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backBtn.snp.makeConstraints { make in
            make.top.leading.equalTo(safeAreaLayoutGuide).inset(16)
            make.size.equalTo(24)
        }
        
        addBtn.snp.makeConstraints { make in
            make.top.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.size.equalTo(24)
        }
        
        titleLbl.snp.makeConstraints { make in
            make.top.equalTo(backBtn.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        songsLbl.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(8)
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        songsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(songsLbl.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalTo(safeAreaLayoutGuide).inset(16)
        }
    }
}
