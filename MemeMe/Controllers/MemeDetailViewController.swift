//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Gozde Kardas on 8.04.2021.
//  Copyright © 2021 Gozde Kardas. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    var image : UIImage!
    
    @IBOutlet weak var memeImage: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.memeImage!.image = image
        self.tabBarController?.tabBar.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
}
