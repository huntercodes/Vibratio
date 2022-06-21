//
//  TitleHeaderCollectionReusableView.swift
//  Vibratio
//
//  Created by hunter downey on 6/21/22.
//

import UIKit

class TitleHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "TitleHeaderCollectionReuseableView"
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "cellTextColor")
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 21, weight: .medium)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(named: "otherColor")
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(
            x: 14,
            y: 0,
            width: width - 27,
            height: height
        )
    }
    
    func configure(with title: String) {
        label.text = title
    }
}
