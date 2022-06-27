//
//  RecommendedMusicCollectionViewCell.swift
//  SpotifyUIKit
//
//  Created by hunter downey on 5/25/22.
//

import UIKit

class RecommendedMusicCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecommendedMusicCollectionViewCell"
    
    private let albumCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private let trackNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(named: "cellTextColor")
        
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .light)
        label.textColor = UIColor(named: "cellTextColor")
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "cellBackgroundColor")
        contentView.backgroundColor = UIColor(named: "cellBackgroundColor")
        contentView.addSubview(albumCoverImageView)
        contentView.addSubview(trackNameLabel)
        contentView.addSubview(artistNameLabel)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageSize = contentView.height - 4
        albumCoverImageView.frame = CGRect(
            x: 2,
            y: 2,
            width: imageSize,
            height: imageSize
        )
        
        artistNameLabel.frame = CGRect(
            x: albumCoverImageView.right + 10,
            y: contentView.height / 2,
            width: contentView.width - albumCoverImageView.right - 16,
            height: contentView.height / 2
        )
        
        trackNameLabel.frame = CGRect(
            x: albumCoverImageView.right + 10,
            y: 0,
            width: contentView.width - albumCoverImageView.right - 16,
            height: contentView.height / 2
        )
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        artistNameLabel.text = nil
        trackNameLabel.text = nil
        albumCoverImageView.image = nil
    }
    
    func configure(with viewModel: RecommendedMusicCellViewModel) {
        albumCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
        trackNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
    }
}
