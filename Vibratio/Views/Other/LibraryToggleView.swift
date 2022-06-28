//
//  LibraryToggleView.swift
//  Vibratio
//
//  Created by hunter downey on 6/27/22.
//

import UIKit

protocol LibraryToggleViewDelegate: AnyObject {
    func libraryToggleViewDidTapPlaylists(_ toggleView: LibraryToggleView)
    func libraryToggleViewDidTapAlbums(_ toggleView: LibraryToggleView)
}

class LibraryToggleView: UIView {
    
    enum State {
        case playlist
        case album
    }
    
    var state: State = .playlist
    
    weak var delegate: LibraryToggleViewDelegate?
    
    private var selectedColor = UIColor(named: "tabBarColor")
    private var unselectedColor = UIColor(named: "cellTextColor")
    
    private let playlistButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(named: "tabBarColor"), for: .normal)
        button.setTitle("Playlists", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 11
        button.backgroundColor = UIColor(named: "reverseTextColor")
        return button
    }()
    
    private let albumButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(named: "cellTextColor"), for: .normal)
        button.setTitle("Albums", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 11
        button.backgroundColor = UIColor(named: "reverseTextColor")
        return button
    }()
    
    private let indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "tabBarColor")
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 11
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(playlistButton)
        addSubview(albumButton)
        addSubview(indicatorView)
        
        playlistButton.addTarget(self, action: #selector(didTapPlaylists), for: .touchUpInside)
        albumButton.addTarget(self, action: #selector(didTapAlbums), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc private func didTapPlaylists() {
        state = .playlist
        UIView.animate(withDuration: 0.23) { [self] in
            self.layoutIndicator()
        }
        delegate?.libraryToggleViewDidTapPlaylists(self)
    }
    
    @objc private func didTapAlbums() {
        state = .album
        UIView.animate(withDuration: 0.23) { [self] in
            self.layoutIndicator()
        }
        delegate?.libraryToggleViewDidTapAlbums(self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        playlistButton.frame = CGRect(
            x: 0,
            y: 0,
            width: 100,
            height: 40
        )
        
        albumButton.frame = CGRect(
            x: playlistButton.right + 4,
            y: 0,
            width: 100,
            height: 40
        )
        
        layoutIndicator()
    }
    
    func layoutIndicator() {
        switch state {
            case .playlist:
            indicatorView.frame = CGRect(
                x: 0,
                y: playlistButton.bottom,
                width: 101,
                height: 1
            )
            playlistButton.setTitleColor(selectedColor, for: .normal)
            albumButton.setTitleColor(unselectedColor, for: .normal)
            
            case .album:
            indicatorView.frame = CGRect(
                x: playlistButton.right + 4,
                y: albumButton.bottom,
                width: 101,
                height: 1
            )
            albumButton.setTitleColor(selectedColor, for: .normal)
            playlistButton.setTitleColor(unselectedColor, for: .normal)
        }
    }
    
    func update(for state: State) {
        self.state = state
        
        UIView.animate(withDuration: 0.175) {
            self.layoutIndicator()
        }
    }
}
