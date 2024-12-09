//
//  AddBottomSheetViewController.swift
//  Spotify
//
//  Created by Felix Liman on 09/12/24.
//

import UIKit

final class AddBottomSheetViewController: UIViewController {
    
    lazy var root = AddBottomSheetView()
    
    var addBtnTapped: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = root
        
        root.addPlaylistBtn.onTapped = { [weak self] in
            self?.addBtnTapped?()
        }
        
        root.onTapped = { [weak self] in
            self?.dismiss(animated: true)
        }
        
        root.addPlaylistBtn.onTapped = { [weak self] in
            self?.addBtnTapped?()
        }
    }
}
