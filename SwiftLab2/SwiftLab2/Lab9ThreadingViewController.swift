//
//  Lab9ThreadingViewController.swift
//  SwiftLab2
//
//  Created by Bayoumi on 28/04/2026.
//

import UIKit

class Lab9ThreadingViewController: UIViewController {
    @IBOutlet weak var loadedImageView: UIImageView!
    
    var isOperation = true
    let queue = OperationQueue()

    override func viewDidLoad() {
        super.viewDidLoad()
/*
        print("-- Async Tasks --")

        DispatchQueue.global().async{
            for _ in 1 ... 10{
                print("Task 1")
            }
        }
        DispatchQueue.global().async{
            for _ in 1 ... 10{
                print("Task 2")
            }
        }
 */
        
        print("-- Sync Tasks --")
        DispatchQueue.global().sync{
            for _ in 1 ... 10{
                print("Task 1")
            }
        }
        DispatchQueue.global().sync{
            for _ in 1 ... 10{
                print("Task 2")
            }
        }
    }
    
    @IBAction func loadImage(_ sender: Any) {
        if isOperation { // Operation and OperationQueue
            let url = URL(string: "https://images.pexels.com/photos/34150285/pexels-photo-34150285/free-photo-of-massive-dump-truck-in-mining-operation.jpeg?auto=compress&cs=tinysrgb&w=600")!

                 let downloadOp = DownloadImageOperation(url: url)

                 let updateUIOp = BlockOperation {
                     guard let image = downloadOp.downloadedImage else { return }

                     DispatchQueue.main.async {
                         self.loadedImageView.image = image
                     }
                 }

                 updateUIOp.addDependency(downloadOp)

                 queue.addOperations([downloadOp, updateUIOp], waitUntilFinished: false)
            
            
        }else {
            let imageURL = URL(string: "https://images.pexels.com/photos/34150285/pexels-photo-34150285/free-photo-of-massive-dump-truck-in-mining-operation.jpeg?auto=compress&cs=tinysrgb&w=600")!
            
            DispatchQueue.global(qos: .background).async {
                do{
                    let data = try Data(contentsOf: imageURL)
                    
                    if let image = UIImage(data: data){
                        
                        DispatchQueue.main.async{
                            self.loadedImageView.image = image
                        }
                    }
                }catch{
                    print("Failed to load image" , error)
                }
            }
        }
       
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
