//
//  String+Extension.swift
//  Spotify
//
//  Created by Felix Liman on 08/12/24.
//

import Foundation

extension String {
    func encodeSpace(with replacement: String) -> String {
        self.replacingOccurrences(of: " ", with: replacement)
    }
    
    func getCleanedURL() -> URL? {
       guard self.isEmpty == false else {
           return nil
       }
       if let url = URL(string: self) {
           return url
       } else {
           if let urlEscapedString = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) , let escapedURL = URL(string: urlEscapedString) {
               return escapedURL
           }
       }
       return nil
    }
}
