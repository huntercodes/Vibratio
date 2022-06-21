//
//  AlbumViewController.swift
//  SpotifyUIKit
//
//  Created by hunter downey on 6/2/22.
//

import UIKit

class AlbumViewController: UIViewController {
    
    private let album: Album
    
    init(album: Album) {
        self.album = album
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = album.name
        view.backgroundColor = UIColor(named: "otherColor")
        
        APICaller.shared.getAlbumDetails(for: album) { result in
            DispatchQueue.main.async {
                switch result {
                case.success(let model):
                    break
                case .failure(let error):
                    break
                }
            }
        }
    }
    
    
}
