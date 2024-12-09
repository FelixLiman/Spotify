//
//  SongResultModel.swift
//  Spotify
//
//  Created by Felix Liman on 08/12/24.
//

import Foundation

struct SongResultModel: Codable {
    let resultCount: Int?
    let results: [SongModel]?
}
