//
//  DownloadImageOperation.swift
//  SwiftLab2
//
//  Created by Bayoumi on 28/04/2026.
//

import Foundation
import UIKit
class DownloadImageOperation: Operation {

    let url: URL
    var downloadedImage: UIImage?

    init(url: URL) {
        self.url = url
    }

    override func main() {
        if isCancelled { return }

        do {
            let data = try Data(contentsOf: url)
            if isCancelled { return }

            downloadedImage = UIImage(data: data)
        } catch {
            print("Download failed:", error)
        }
    }
}
