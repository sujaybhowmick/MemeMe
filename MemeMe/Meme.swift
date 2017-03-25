//
//  Meme.swift
//  MemeMe
//
//  Created by Sujay Bhowmick on 3/25/17.
//  Copyright © 2017 Sujay Bhowmick. All rights reserved.
//

import UIKit

struct Meme {
    
    var topText: String
    var bottomText: String
    var image: UIImage
    var memedImage: UIImage
    
    // Constructor
    init(topText: String, bottomText: String, image: UIImage, memedImage: UIImage){
        self.topText = topText
        self.bottomText = bottomText
        self.image = image
        self.memedImage = memedImage
    }
}
