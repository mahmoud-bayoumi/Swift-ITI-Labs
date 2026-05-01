//
//  CategoryCollectionViewCell.swift
//  ResturantTask_Lab10
//
//  Created by Bayoumi on 30/04/2026.
//


import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bannerImageView.backgroundColor = UIColor.systemGray6
        bannerImageView.layer.cornerRadius = 22   
        bannerImageView.clipsToBounds = true
        bannerImageView.contentMode = .scaleAspectFit
        
        titleLabel.font = .systemFont(ofSize: 11)
        titleLabel.textColor = .darkGray
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
    }
    
    func configure(image: String, title: String) {
        bannerImageView.image = UIImage(named: image)
        titleLabel.text = title
    }
}
