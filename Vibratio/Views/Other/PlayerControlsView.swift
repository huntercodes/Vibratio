//
//  PlayerControlsView.swift
//  Vibratio
//
//  Created by hunter downey on 6/26/22.
//

import UIKit

protocol PlayerControlsViewDelegate: AnyObject {
    func playerControlsViewDidTapPlayPause(_ playerControlsView: PlayerControlsView)
    func playerControlsViewDidTapBackward(_ playerControlsView: PlayerControlsView)
    func playerControlsViewDidTapForward(_ playerControlsView: PlayerControlsView)
}

final class PlayerControlsView: UIView {
    
    weak var delegate: PlayerControlsViewDelegate?
    
    private let volumeSlider: UISlider = {
        let slider = UISlider()
        slider.value = 0.3
        slider.thumbTintColor = UIColor(named: "otherColor")
        slider.tintColor = UIColor(named: "otherColor")
        return slider
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "cellTextColor")
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 23, weight: .medium)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "cellTextColor")
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 17, weight: .light)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let backwardButton: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor(named: "cellTextColor")
        let image = UIImage(systemName: "backward.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 47, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let forwardButton: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor(named: "cellTextColor")
        let image = UIImage(systemName: "forward.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 47, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let playPauseButton: UIButton = {
        let button = UIButton()
        button.tintColor = UIColor(named: "cellTextColor")
        let image = UIImage(systemName: "pause.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 47, weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "cellBackgroundColor")
        addSubview(nameLabel)
        addSubview(subtitleLabel)
        
        addSubview(volumeSlider)
        
        addSubview(backwardButton)
        addSubview(forwardButton)
        addSubview(playPauseButton)
        
        backwardButton.addTarget(self, action: #selector(didTapBackward), for: .touchUpInside)
        forwardButton.addTarget(self, action: #selector(didTapForward), for: .touchUpInside)
        playPauseButton.addTarget(self, action: #selector(didTapPlayPause), for: .touchUpInside)
        
        clipsToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc private func didTapBackward() {
        delegate?.playerControlsViewDidTapBackward(self)
    }
    
    @objc private func didTapForward() {
        delegate?.playerControlsViewDidTapForward(self)
    }
    
    @objc private func didTapPlayPause() {
        delegate?.playerControlsViewDidTapPlayPause(self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let buttonSize: CGFloat = 60
        
        nameLabel.frame = CGRect(
            x: 14,
            y: 10,
            width: width,
            height: 50
        )
        
        subtitleLabel.frame = CGRect(
            x: 14,
            y: nameLabel.bottom,
            width: width,
            height: 50
        )
        
        volumeSlider.frame = CGRect(
            x: 14,
            y: subtitleLabel.bottom + 20,
            width: width - 28,
            height: 44
        )
        
        playPauseButton.frame = CGRect(
            x: (width - buttonSize) / 2,
            y: volumeSlider.bottom + 27,
            width: buttonSize,
            height: buttonSize
        )
        
        forwardButton.frame = CGRect(
            x: playPauseButton.right + 53,
            y: playPauseButton.top,
            width: buttonSize,
            height: buttonSize
        )
        
        backwardButton.frame = CGRect(
            x: playPauseButton.left - buttonSize - 53,
            y: playPauseButton.top,
            width: buttonSize,
            height: buttonSize
        )
    }
    
    func configure(with viewModel: PlayerControlsViewViewModel) {
        nameLabel.text = viewModel.name
        subtitleLabel.text = viewModel.artistName
    }
}
