//
//  UIImageView+Extension.swift
//  SwiftLab4
//
//  Created by Bayoumi on 19/04/2026.
//

import UIKit

extension UIImageView{
    func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }.resume()
    }
}
