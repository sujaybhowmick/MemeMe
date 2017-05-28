//
//  MemeMeDetailedViewController.swift
//  MemeMe
//
//  Created by Sujay Bhowmick on 5/27/17.
//  Copyright © 2017 Sujay Bhowmick. All rights reserved.
//

import UIKit

class MemeMeDetailedViewController: UIViewController {
    
    var meme: Meme!
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
        
        self.imageView!.image = meme.memedImage
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
}
