//
//  PlaylistDetailViewController.swift
//  Spotify
//
//  Created by Felix Liman on 08/12/24.
//

import UIKit

final class PlaylistDetailViewController: UIViewController {
    
    lazy var root = PlaylistDetailView()
    var viewModel: PlaylistDetailViewModel
    
    var onPlaylistUpdated: ((PlaylistModel) -> Void)?
    
    init(viewModel: PlaylistDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = root
        
        viewModel.onPlaylistUpdated = { [weak self] in
            guard let self else { return }
            self.onPlaylistUpdated?(self.viewModel.playlist)
            self.root.titleLbl.text = self.viewModel.playlist.title
            self.root.songsLbl.text = "\(self.viewModel.playlist.songs.count) songs"
            self.root.songsCollectionView.reloadSections(IndexSet(integer: 0))
        }
        
        root.titleLbl.text = viewModel.playlist.title
        root.songsLbl.text = "\(viewModel.playlist.songs.count) songs"
        
        root.backBtn.onTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        root.addBtn.onTapped = { [weak self] in
            let vm = AddSongViewModel()
            let vc = AddSongViewController(viewModel: vm)
            vc.onSongSelected = { [weak self] song in
                self?.viewModel.addToPlaylist(song)
            }
            vc.modalPresentationStyle = .fullScreen
            self?.navigationController?.present(vc, animated: true)
        }
        
        
        if #available(iOS 17.0, *) {
            registerForTraitChanges([UITraitUserInterfaceStyle.self]) { [weak self] (traitEnvironment: Self, previousTraitCollection) in
                self?.root.setupLayers()
            }
        }
        
        root.songsCollectionView.dataSource = self
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.root.setupLayers()
    }
    
    override func viewDidLayoutSubviews() {
        root.setupGeometry()
        root.setupLayers()
    }
}

extension PlaylistDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.playlist.songs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: SongListCell.identifier, for: indexPath) as? SongListCell) ?? SongListCell()
        cell.model = viewModel.playlist.songs[indexPath.item]

        return cell
    }
}
