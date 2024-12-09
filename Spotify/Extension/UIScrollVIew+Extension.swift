//
//  UIScrollVIew+Extension.swift
//  Spotify
//
//  Created by Felix Liman on 08/12/24.
//

import UIKit

extension UIScrollView {
    public func prepareToShowKeyboard(_ notification: Notification) {
        let userInfo: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardInfo = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue
        let keyboardSize = keyboardInfo?.cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize?.height ?? 0, right: 0)

        contentInset = contentInsets
        scrollIndicatorInsets = contentInsets
    }
}
