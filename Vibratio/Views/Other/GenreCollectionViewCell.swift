//
//  GenreCollectionViewCell.swift
//  Vibratio
//
//  Created by hunter downey on 6/21/22.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    static let identifier = "GenreCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(named: "cellTextColor")
        imageView.image = UIImage(
            systemName: "music.quarternote.3",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 45, weight: .medium)
        )
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "cellTextColor")
        label.font = .systemFont(ofSize: 19, weight: .semibold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 7
        contentView.layer.masksToBounds = true
        contentView.addSubview(imageView)
        contentView.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame = CGRect(
            x: 10,
            y: contentView.height / 2,
            width: contentView.width - 20,
            height: contentView.height / 2
        )
        
        imageView.frame = CGRect(
            x: contentView.width / 2,
            y: 0,
            width: contentView.width / 2,
            height: contentView.height / 2
        )
    }
    
    func configure(with title: String) {
        label.text = title
        contentView.backgroundColor = UIColor(named: "cellBackgroundColor")
    }
}
