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
    
    
    let memes = (UIApplication.shared.delegate as! AppDelegate).memes
    
    
 /*   override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }*/
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(memes.count)
        return self.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SentMemesCollectionViewCell", for:   indexPath) as! SentMemesCollectionViewCell
        
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        cell.memeImageView.image = meme.memedImage
        
        return cell
    }
    
   
    
  /*  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "VillainDetailViewController") as! VillainDetailViewController
        detailController.villain = self.allVillains[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(detailController, animated: true)
        
    }*/
    
}

    
    
    
    
    


