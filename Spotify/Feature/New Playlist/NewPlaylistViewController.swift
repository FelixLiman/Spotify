//
//  NewPlaylistViewController.swift
//  Spotify
//
//  Created by Felix Liman on 08/12/24.
//

import UIKit

final class NewPlaylistViewController: UIViewController {
    
    lazy var root = NewPlaylistView()
    
    var createBtnTapped: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = root
        
        root.titleTF.text = "My playlist #\(AppData.playlists.count + 1)"
        root.titleTF.placeholder = "My playlist #\(AppData.playlists.count + 1)"
        
        root.createBtn.onTapped = { [weak self] in
            guard let playlistTitle = self?.root.titleTF.text else { return }
            self?.createBtnTapped?(playlistTitle)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        root.titleTF.becomeFirstResponder()
        root.titleTF.selectAll(nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        root.setupGeometry()
    }
}
