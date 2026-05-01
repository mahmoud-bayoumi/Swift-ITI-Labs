//
//  RestaurantCollectionViewCell.swift
//  ResturantTask_Lab10
//
//  Created by Bayoumi on 30/04/2026.
//


import UIKit

class RestaurantCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var cuisineLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var offerLabel: UILabel!
    
    private let discountBadge: UILabel = {
        let label = UILabel()
        label.text = "20% OFF\nUPTO ₹140"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 10, weight: .heavy)
        label.textColor = .white
        label.backgroundColor = UIColor(red: 0.0, green: 0.35, blue: 0.75, alpha: 0.9)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let offerBackground: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(red: 1.0, green: 0.93, blue: 0.82, alpha: 1.0)
        v.layer.cornerRadius = 6
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCard()
        setupBadge()
        setupOfferBackground()
    }
    
    private func setupCard() {
        contentView.layer.cornerRadius = 14
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .white
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 6
        layer.shadowOpacity = 0.12
        layer.masksToBounds = false
        
        bannerImageView.contentMode = .scaleAspectFill
        bannerImageView.clipsToBounds = true
        bannerImageView.layer.cornerRadius = 10
    }
    
    private func setupBadge() {
        bannerImageView.addSubview(discountBadge)
        NSLayoutConstraint.activate([
            discountBadge.leadingAnchor.constraint(equalTo: bannerImageView.leadingAnchor),
            discountBadge.trailingAnchor.constraint(equalTo: bannerImageView.trailingAnchor),
            discountBadge.bottomAnchor.constraint(equalTo: bannerImageView.bottomAnchor),
            discountBadge.heightAnchor.constraint(equalToConstant: 34)
        ])
    }
    
    private func setupOfferBackground() {
        guard let parent = offerLabel.superview else { return }
        parent.insertSubview(offerBackground, belowSubview: offerLabel)
        
        NSLayoutConstraint.activate([
            offerBackground.leadingAnchor.constraint(equalTo: offerLabel.leadingAnchor, constant: -8),
            offerBackground.trailingAnchor.constraint(equalTo: offerLabel.trailingAnchor, constant: 8),
            offerBackground.topAnchor.constraint(equalTo: offerLabel.topAnchor, constant: -2),
            offerBackground.bottomAnchor.constraint(equalTo: offerLabel.bottomAnchor, constant: 2)
        ])
        
        offerLabel.textAlignment = .left
    }
    
    func configure(name: String, rating: String, time: String, price: String,
                   cuisine: String, location: String, offer: String,
                   imageName: String, discount: String = "20% OFF\nUPTO ₹140") {
        bannerImageView.image = UIImage(named: imageName)
        titleLabel.text = name
        ratingLabel.text = "★ \(rating)  •  \(time)  •  \(price)"
        cuisineLabel.text = cuisine
        locationLabel.text = location
        offerLabel.text = "  \(offer)"
        discountBadge.text = discount
    }
}
