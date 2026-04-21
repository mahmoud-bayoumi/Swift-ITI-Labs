//
//  TableViewCell.swift
//  SwiftLab4
//
//  Created by Bayoumi on 19/04/2026.
//

import UIKit
import Kingfisher  

class TableViewCell: UITableViewCell {
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        itemImageView.clipsToBounds = true
        itemImageView.contentMode = .scaleAspectFill
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // This runs AFTER Auto Layout sets the frame
        // Ensures a perfect circle every time
        itemImageView.layer.cornerRadius = itemImageView.bounds.width / 2
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
