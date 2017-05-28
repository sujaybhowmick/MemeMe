//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Sujay Bhowmick on 5/29/17.
//  Copyright © 2017 Sujay Bhowmick. All rights reserved.
//

import Foundation
import UIKit


class MemeCollectionViewController: UICollectionViewController {
    
    
    @IBOutlet weak var flowlayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let space: CGFloat = 3.0
        let dimension = (self.view.frame.size.width - 2 * space) / space
        flowlayout.minimumInteritemSpacing = space
        flowlayout.minimumLineSpacing = space
        flowlayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MemeCollection.count()
    }
   
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        
        let meme = MemeCollection.getMeme(atIndex: indexPath.row)
        
        cell.imageView?.image = meme.memedImage
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeMeDetailedViewController") as! MemeMeDetailedViewController
        detailController.meme = MemeCollection.getMeme(atIndex: indexPath.row)
        self.navigationController!.pushViewController(detailController, animated: true)
    }
}
