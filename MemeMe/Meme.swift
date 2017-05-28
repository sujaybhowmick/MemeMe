//
//  Meme.swift
//  MemeMe
//
//  Created by Sujay Bhowmick on 3/25/17.
//  Copyright © 2017 Sujay Bhowmick. All rights reserved.
//

import UIKit

struct Meme {
    
    let topText: String
    let bottomText: String
    let image: UIImage
    let memedImage: UIImage
}

extension Meme: Equatable {}

func ==(lhs: Meme, rhs: Meme) -> Bool {
    return lhs.memedImage == rhs.memedImage
}

struct MemeCollection {
    static var allMemes: [Meme] {
        return getMemeStorage().memes
    }
    
    static func count() -> Int {
        return getMemeStorage().memes.count
    }
    
    static func add(_ meme: Meme) {
        getMemeStorage().memes.append(meme)
    }
    
    static func getMeme(atIndex index: Int) -> Meme {
        return allMemes[index]
    }
    
    static func getMemeStorage() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}


