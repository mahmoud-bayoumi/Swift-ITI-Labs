//
//  HeaderReusableView.swift
//  ResturantTask_Lab10
//
//  Created by Bayoumi on 01/05/2026.
//

import UIKit

class HeaderReusableView: UICollectionReusableView {
    static let identifier = "HeaderReusableView"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "ALL RESTAURANTS"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let sortFilterLabel: UILabel = {
        let label = UILabel()
        label.text = "Sort/Filter"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(sortFilterLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            sortFilterLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            sortFilterLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
