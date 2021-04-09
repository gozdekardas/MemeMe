//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Gozde Kardas on 31.03.2021.
//  Copyright © 2021 Gozde Kardas. All rights reserved.
//
import Foundation
import UIKit

class SentMemesCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme]!{
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2*space)) / 3.0
        
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        
    }
    
    // MARK: Open Create Meme Page
    @IBAction func openCreateMeme(_ sender: Any) {
        
        let memeViewController = self.storyboard!.instantiateViewController(withIdentifier: "MemeViewController") as! MemeViewController
        self.present(memeViewController, animated: true, completion: nil)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView!.reloadData()
        print(self.memes.count)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SentMemesCollectionViewCell", for:   indexPath) as! SentMemesCollectionViewCell
        let meme = self.memes[(indexPath as NSIndexPath).row]
        cell.memeImageView.image = meme.memedImage
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailController.image
            = self.memes[(indexPath as NSIndexPath).row].memedImage
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }
    
}








