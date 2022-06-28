//
//  ActionLabelView.swift
//  Vibratio
//
//  Created by hunter downey on 6/28/22.
//

import UIKit

protocol ActionLabelViewDelegate: AnyObject {
    func actionLabelViewDidTapButton(_ actionView: ActionLabelView)
}

class ActionLabelView: UIView {
    
    weak var delegate: ActionLabelViewDelegate?
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = UIColor(named: "cellTextColor")
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(named: "tabBarColor"), for: .normal)
        button.backgroundColor = UIColor(named: "reverseTextColor")
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        isHidden = true
        addSubview(label)
        addSubview(button)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    @objc func didTapButton() {
        delegate?.actionLabelViewDidTapButton(self)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        label.frame = CGRect(
            x: 0,
            y: 0,
            width: width,
            height: height - 45
        )
        
        button.frame = CGRect(
            x: 0,
            y: height - 40,
            width: width,
            height: 40
        )
    }
    
    func configure(with viewModel: ActionLabelViewModel) {
        label.text = viewModel.text
        button.setTitle(viewModel.actionTitle, for: .normal)
    }
}
