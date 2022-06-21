//
//  FeaturedPlaylistCollectionViewCell.swift
//  SpotifyUIKit
//
//  Created by hunter downey on 5/25/22.
//

import UIKit

class FeaturedPlaylistCollectionViewCell: UICollectionViewCell {
    static let identifier = "FeaturedPlaylistCollectionViewCell"
    
    private let playlistCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 7
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private let playlistNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = UIColor(named: "cellTextColor")
        
        return label
    }()
    
    private let creatorNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.textColor = UIColor(named: "cellTextColor")
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(playlistCoverImageView)
        contentView.addSubview(playlistNameLabel)
        contentView.addSubview(creatorNameLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        creatorNameLabel.frame = CGRect(
            x: 3,
            y: contentView.height - 32,
            width: contentView.width - 6,
            height: 32
        )
        
        playlistNameLabel.frame = CGRect(
            x: 3,
            y: contentView.height - 58,
            width: contentView.width - 6,
            height: 32
        )
        
        let imageSize = contentView.height - 64
        playlistCoverImageView.frame = CGRect(
            x: (contentView.width - imageSize) / 2,
            y: 3,
            width: imageSize,
            height: imageSize
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        creatorNameLabel.text = nil
        playlistNameLabel.text = nil
        playlistCoverImageView.image = nil
    }
    
    func configure(with viewModel: FeaturedPlaylistsCellViewModel) {
        playlistNameLabel.text = viewModel.name
        creatorNameLabel.text = "\(viewModel.creatorName)-Made"
        playlistCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
}
