//
//  AddSongViewModel.swift
//  Spotify
//
//  Created by Felix Liman on 08/12/24.
//

import Foundation
import Alamofire

enum AddSongViewState {
    case recent
    case result
}

final class AddSongViewModel {
    var onStateUpdated: (() -> Void)?
    var onSongSelected: ((SongModel) -> Void)?
    var onSongsUpdated: (() -> Void)?
    var onSongsFailed: ((Error) -> Void)?
    
    private(set) var state: AddSongViewState {
        didSet {
            onStateUpdated?()
        }
    }
    
    private(set) var recentSongs: [SongModel] {
        didSet {
            AppData.recentSearches = recentSongs
        }
    }
    
    private(set) var songs: [SongModel] {
        didSet {
            onSongsUpdated?()
        }
    }
    
    init() {
        state = .recent
        recentSongs = AppData.recentSearches
        songs = []
    }
    
    func showRecentSongs() {
        state = .recent
    }
    
    func fetchSongs(search: String) {
        let session = Session.default
        let router = APIAction.getSong(search: search, limit: 15)
        
        state = .result
        Session.default.session.cancelAllOngoingRequest {
            debugPrint(search.encodeSpace(with: "+"))
            NetworkManager(session: session, router: router).request(type: SongResultModel.self) { [weak self] model in
                self?.songs = model.results ?? []
            } failed: { [weak self] error in
                self?.onSongsFailed?(error)
            }
        }
    }
    
    func selected(song: SongModel) {
        recentSongs.removeAll(where: { $0.id == song.id })
        recentSongs.insert(song, at: 0)
        
        onSongSelected?(song)
    }
}
