//
//  SongModel.swift
//  Spotify
//
//  Created by Felix Liman on 08/12/24.
//

import Foundation

struct SongModel: Codable, Equatable {
    let id: Int?
    let kind: String?
    let artistName: String?
    let trackName: String?
    let artworkUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case kind
        case artistName
        case trackName
        case artworkUrl = "artworkUrl100"
    }
    
    init(id: Int?, kind: String?, artistName: String?, trackName: String?, artworkUrl: String?) {
        self.id = id
        self.kind = kind?.capitalized
        self.artistName = artistName
        self.trackName = trackName
        self.artworkUrl = artworkUrl
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        kind = try container.decodeIfPresent(String.self, forKey: .kind)?.capitalized
        artistName = try container.decodeIfPresent(String.self, forKey: .artistName)
        trackName = try container.decodeIfPresent(String.self, forKey: .trackName)
        artworkUrl = try container.decodeIfPresent(String.self, forKey: .artworkUrl)
    }
}
