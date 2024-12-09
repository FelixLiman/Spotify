//
//  AddSongViewController.swift
//  Spotify
//
//  Created by Felix Liman on 08/12/24.
//

import UIKit

final class AddSongViewController: UIViewController {
    
    lazy var root = AddSongView()
    private var viewModel: AddSongViewModel
    private var searchText: String = ""
    
    var onSongSelected: ((SongModel) -> Void)?
    
    init(viewModel: AddSongViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = root
        viewModel = AddSongViewModel()
        
        viewModel.fetchSongs(search: searchText)
        
        viewModel.onStateUpdated = { [weak self] in
            guard let self else { return }
            self.root.updateState(state: self.viewModel.state)
        }
        
        viewModel.onSongsUpdated = { [weak self] in
            self?.root.resultCollectionView.performBatchUpdates({ [weak self] in
                self?.root.resultCollectionView.reloadSections(IndexSet(integer: 0))
            })
        }
        
        viewModel.onSongSelected = { [weak self] song in
            self?.onSongSelected?(song)
            self?.dismiss(animated: true)
        }
        
        root.searchBar.delegate = self
        
        root.recentCollectionView.delegate = self
        root.recentCollectionView.dataSource = self
        
        root.resultCollectionView.delegate = self
        root.resultCollectionView.dataSource = self
        
        root.cancelBtn.onTapped = { [weak self] in
            self?.dismiss(animated: true)
        }
    }
    
    override func viewDidLayoutSubviews() {
        root.setupGeometry()
    }
}

extension AddSongViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            viewModel.showRecentSongs()
        } else {
            print("\(searchText) will be encoded into \(searchText.encodeSpace(with: "+"))")
            viewModel.fetchSongs(search: searchText)
        }
    }
}

extension AddSongViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard collectionView == root.recentCollectionView else { return CGSize.zero }
        let headerView = RecentSearchHeaderView()
        let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        
        return CGSize(width: collectionView.frame.width, height: height)
    }
}

extension AddSongViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == root.recentCollectionView {
            return viewModel.recentSongs.count
        } else if collectionView == root.resultCollectionView {
            return viewModel.songs.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard collectionView == root.recentCollectionView else { return UICollectionReusableView() }
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: RecentSearchHeaderView.identifier, for: indexPath) as? RecentSearchHeaderView
        return headerView ?? RecentSearchHeaderView()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: SongListCell.identifier, for: indexPath) as? SongListCell) ?? SongListCell()
        cell.moreBtn.alpha = 0
        if collectionView == root.recentCollectionView {
            cell.model = viewModel.recentSongs[indexPath.item]
        } else if collectionView == root.resultCollectionView {
            cell.model = viewModel.songs[indexPath.item]
        }
        return cell
    }
}

extension AddSongViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == root.recentCollectionView {
            let song = viewModel.recentSongs[indexPath.item]
            viewModel.selected(song: song)
        } else if collectionView == root.resultCollectionView {
            let song = viewModel.songs[indexPath.item]
            viewModel.selected(song: song)
        }
    }
}
