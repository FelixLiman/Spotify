//
//  UIImageView+Extension.swift
//  Spotify
//
//  Created by Felix Liman on 09/12/24.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(string: String?, completion: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil ) {
        guard let string = string,
              let url = string.getCleanedURL()
        else {
            return
        }

        let imageResource = Kingfisher.KF.ImageResource(downloadURL: url)
        self.kf.setImage(with: imageResource, placeholder: UIImage(named: "brokenImage")) { result in
            if let completion = completion {
                completion(result)
            }
        }
    }

}
