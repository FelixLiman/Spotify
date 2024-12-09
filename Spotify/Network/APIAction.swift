//
//  APIAction.swift
//  Spotify
//
//  Created by Felix Liman on 08/12/24.
//

import Foundation
import Alamofire

enum APIAction {
    case getSong(search: String, limit: Int)
}

extension APIAction: APIRouter {

    var method: HTTPMethod {
        switch self {
        case .getSong:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getSong:
            return "search"
        }
    }

    var actionParameters: [String: Any] {
        switch self {
        case .getSong(let search, let limit):
            return [
                "term": search,
                "limit": limit,
                "country": "ID",
                "media": "music",
                "entities": "musicTrack"
            ]
        }
    }

    var baseURL: String {
        return "https://itunes.apple.com/"
    }

    var authHeader: HTTPHeaders? {
        return [:]
    }

    var multipartFormData: MultipartFormData {
        let multipartFormData = MultipartFormData()
        return multipartFormData
    }

    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
}
