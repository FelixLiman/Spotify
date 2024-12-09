//
//  ViewController.swift
//  Spotify
//
//  Created by Felix Liman on 06/12/24.
//

import UIKit

class PlaylistViewController: UIViewController {

    lazy var root = PlaylistView()
    
    private var viewModel: PlaylistViewModel
    
    init(viewModel: PlaylistViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = root
        viewModel = PlaylistViewModel()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        root.playlistCollectionView.delegate = self
        root.playlistCollectionView.dataSource = self
        
        viewModel.onPlaylistsUpdated = { [weak self] in
            self?.root.playlistCollectionView.performBatchUpdates({ [weak self] in
                self?.root.playlistCollectionView.reloadSections(IndexSet(integer: 0))
            })
        }
        
        viewModel.onPlaylistViewTypeUpdated = { [weak self] in
            guard let self else { return }
            root.transitionLayout(to: viewModel.playlistViewType)
        }
        
        root.addBtn.onTapped = { [weak self] in
            self?.pushToAddBottomSheet()
        }
        
        if #available(iOS 17.0, *) {
            registerForTraitChanges([UITraitUserInterfaceStyle.self]) { [weak self] (traitEnvironment: Self, previousTraitCollection) in
                self?.root.setupLayers()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        root.setupGeometry()
        root.setupLayers()
        root.transitionLayout(to: viewModel.playlistViewType)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.root.setupLayers()
    }
    
    @objc private func togglePlaylistView() {
        viewModel.togglePlaylistViewType()
    }
    
    private func pushToAddBottomSheet() {
        let vc = AddBottomSheetViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.addBtnTapped = { [weak self] in
            self?.root.isUserInteractionEnabled = false
            self?.dismiss(animated: true) {
                self?.pushToNewPlaylist()
                self?.root.isUserInteractionEnabled = true
            }
        }
        self.navigationController?.present(vc, animated: true)
    }
    
    private func pushToNewPlaylist() {
        let vc = NewPlaylistViewController()
        vc.createBtnTapped = { [weak self] title in
            self?.viewModel.createNewPlaylist(title: title)
            self?.root.isUserInteractionEnabled = false
            self?.dismiss(animated: true) {
                self?.pushToPlaylistDetailUponCreation()
                self?.root.isUserInteractionEnabled = true
            }
        }
        self.navigationController?.present(vc, animated: true)
    }
    
    private func pushToPlaylistDetailUponCreation() {
        guard let playlist = self.viewModel.playlists.last else { return }
        let detailVM = PlaylistDetailViewModel(playlist: playlist)
        let detailVC = PlaylistDetailViewController(viewModel: detailVM)
        detailVC.onPlaylistUpdated = { [weak self] playlist in
            self?.viewModel.updatePlaylists(playlist)
        }
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension PlaylistViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let headerView = PlaylistHeaderView()
        let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        
        return CGSize(width: collectionView.frame.width, height: height)
    }
}

extension PlaylistViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.playlists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = (collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: PlaylistHeaderView.identifier, for: indexPath) as? PlaylistHeaderView) ?? PlaylistHeaderView()
        headerView.sortBtn.isHidden = viewModel.playlistViewType == .list
        headerView.sortTypeLbl.isHidden = viewModel.playlistViewType == .list
        headerView.changeStyleBtn.onTapped = { [weak self] in
            self?.viewModel.togglePlaylistViewType()
        }
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell
        
        switch viewModel.playlistViewType {
        case .grid:
            let dequeuedCell = (collectionView.dequeueReusableCell(withReuseIdentifier: PlaylistGridCell.identifier, for: indexPath) as? PlaylistGridCell) ?? PlaylistGridCell()
            dequeuedCell.model = viewModel.playlists[indexPath.item]
            cell = dequeuedCell
        case .list:
            let dequeuedCell = (collectionView.dequeueReusableCell(withReuseIdentifier: PlaylistListCell.identifier, for: indexPath) as? PlaylistListCell) ?? PlaylistListCell()
            dequeuedCell.model = viewModel.playlists[indexPath.item]
            cell = dequeuedCell
        }
        
        return cell
    }
}

extension PlaylistViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let playlist = viewModel.playlists[indexPath.item]
        let detailVM = PlaylistDetailViewModel(playlist: playlist)
        let detailVC = PlaylistDetailViewController(viewModel: detailVM)
        detailVC.onPlaylistUpdated = { [weak self] playlist in
            self?.viewModel.updatePlaylists(playlist)
        }
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
