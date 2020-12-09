//
//  ViewProgressUpdateViewController.swift
//  Progress Journal
//
//  Created by Simon Wilson on 09/12/2020.
//

import UIKit

class ViewProgressUpdateViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    var progressUpdate : ProgressUpdate?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = progressUpdate?.title
        
        if let imageData = progressUpdate?.image {
            
            photoImageView.image = UIImage(data: imageData)
            
        }
        
        
    }
    
}
