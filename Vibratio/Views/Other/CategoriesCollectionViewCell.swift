//
//  CategoriesCollectionViewCell.swift
//  Vibratio
//
//  Created by hunter downey on 6/21/22.
//

import UIKit
import SDWebImage

class CategoriesCollectionViewCell: UICollectionViewCell {
    static let identifier = "CategoriesCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = UIColor(named: "cellTextColor")
        imageView.image = UIImage(
            systemName: "music.quarternote.3",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 55, weight: .medium)
        )
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 11
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
        imageView.image = UIImage(
            systemName: "music.quarternote.3",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 55, weight: .medium)
        )
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame = CGRect(
            x: 10,
            y: contentView.height / 1.75,
            width: contentView.width - 20,
            height: contentView.height / 2
        )
        
        imageView.frame = CGRect(
            x: contentView.width / 2.2,
            y: 10,
            width: contentView.width / 1.8,
            height: contentView.height / 1.8
        )
    }
    
    func configure(with viewModel: CategoryCollectionViewModel) {
        label.text = viewModel.title
        imageView.sd_setImage(
            with: viewModel.artworkURL,
            completed: nil
        )
        contentView.backgroundColor = UIColor(named: "cellBackgroundColor")
    }
}
