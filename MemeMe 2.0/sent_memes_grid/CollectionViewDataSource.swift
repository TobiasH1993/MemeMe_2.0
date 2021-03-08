//
//  CollectionViewDataSource.swift
//  MemeMe 2.0
//
//  Created by Haeussermann, Tobias (059) on 08.03.21.
//

import Foundation
import UIKit

class CollectionViewDataSource : NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (UIApplication.shared.delegate as! AppDelegate).memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let memes = (UIApplication.shared.delegate as! AppDelegate).memes
        
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "memeCell", for: indexPath) as! CollectionViewCell
        collectionCell.config(memeData: memes[indexPath.row])
        return collectionCell
    }
}
