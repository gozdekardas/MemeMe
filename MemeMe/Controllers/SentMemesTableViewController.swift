//
//  SentMemesTableViewController.swift
//  MemeMe
//
//  Created by Gozde Kardas on 8.04.2021.
//  Copyright © 2021 Gozde Kardas. All rights reserved.
//

import UIKit

class SentMemesTableViewController:  UITableViewController {
    
    var memes: [Meme]!{
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView!.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    // MARK: open create meme
    @IBAction func openCreateMeme(_ sender: Any) {
        let memeViewController = self.storyboard!.instantiateViewController(withIdentifier: "MemeViewController") as! MemeViewController
        self.present(memeViewController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableCell")!
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        // Set the text and image
        cell.textLabel?.text = "\(meme.topText)...\(meme.bottomText)"
        cell.imageView?.image = meme.memedImage
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
       detailController.image
            = self.memes[(indexPath as NSIndexPath).row].memedImage
        self.navigationController!.pushViewController(detailController, animated: true)
    }
}
