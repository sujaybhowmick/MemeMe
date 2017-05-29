//
//  ViewController.swift
//  MemeMe
//
//  Created by Sujay Bhowmick on 5/22/17.
//  Copyright © 2017 Sujay Bhowmick. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView!.reloadData()
        
    }
    
    @IBAction func addMeme(_ sender: Any) {
        var controller: MemeMeEditorViewController
        controller = self.storyboard?.instantiateViewController(withIdentifier: "MemeMeEditorViewController") as! MemeMeEditorViewController
        self.present(controller, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MemeCollection.count()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell")!
        let meme = MemeCollection.getMeme(atIndex: indexPath.row)
        
        cell.textLabel?.text = meme.topText + "..." + meme.bottomText + "..."
        cell.imageView?.image = meme.memedImage
        
        return cell

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeMeDetailedViewController") as! MemeMeDetailedViewController
        detailController.meme = MemeCollection.getMeme(atIndex: indexPath.row)
        self.navigationController!.pushViewController(detailController, animated: true)
    }
}
