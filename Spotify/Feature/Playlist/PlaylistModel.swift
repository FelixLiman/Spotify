//
//  PlaylistModel.swift
//  Spotify
//
//  Created by Felix Liman on 06/12/24.
//

import Foundation

struct PlaylistModel: Codable, Equatable {
    let id: Int
    let title: String
    var songs: [SongModel]
    
    static func == (lhs: PlaylistModel, rhs: PlaylistModel) -> Bool {
        lhs.id == rhs.id
    }
}
