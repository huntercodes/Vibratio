//
//  PlayerViewController.swift
//  SpotifyUIKit
//
//  Created by hunter downey on 4/27/22.
//

import UIKit
import SDWebImage

protocol PlayerViewControllerDelegate: AnyObject {
    func didTapPlayPause()
    func didTapForward()
    func didTapBackward()
    func didSlideSlider(_ value: Float)
}

class PlayerViewController: UIViewController {
    
    weak var dataSource: PlayerDataSource?
    
    weak var delegate: PlayerViewControllerDelegate?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 37
        imageView.backgroundColor = UIColor(named: "cellBackgroundColor")
        return imageView
    }()

    private let controlsView = PlayerControlsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "otherColor")
        view.addSubview(imageView)
        view.addSubview(controlsView)
        controlsView.layer.masksToBounds = true
        controlsView.layer.cornerRadius = 37
        controlsView.delegate = self
        configureBarButtons()
        configure()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        imageView.frame = CGRect(
            x: 15,
            y: view.safeAreaInsets.top,
            width: view.width - 30,
            height: view.width - 30
        )
        
        controlsView.frame = CGRect(
            x: 15,
            y: imageView.bottom + 10,
            width: view.width - 30,
            height: view.height - imageView.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom - 25
        )
    }
    
    private func configure() {
        imageView.sd_setImage(with: dataSource?.imageURL, completed: nil)
        controlsView.configure(with: PlayerControlsViewViewModel(name: dataSource?.songName, artistName: dataSource?.artistName))
    }

    private func configureBarButtons() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didTapAction))
    }

    @objc private func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapAction() {
        // Actions
    }
    
    func refreshUI() {
        configure()
    }

}

extension PlayerViewController: PlayerControlsViewDelegate {
    func playerControlsViewDidTapPlayPause(_ playerControlsView: PlayerControlsView) {
        delegate?.didTapPlayPause()
    }
    
    func playerControlsViewDidTapBackward(_ playerControlsView: PlayerControlsView) {
        delegate?.didTapBackward()
    }
    
    func playerControlsViewDidTapForward(_ playerControlsView: PlayerControlsView) {
        delegate?.didTapForward()
    }
    
    func playerControlsView(_ playerControlsView: PlayerControlsView, didSlideSlider value: Float) {
        delegate?.didSlideSlider(value)
    }
}
