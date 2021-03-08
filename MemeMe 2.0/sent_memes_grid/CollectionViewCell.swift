//
//  CollectionViewCell.swift
//  MemeMe 2.0
//
//  Created by Haeussermann, Tobias (059) on 08.03.21.
//

import Foundation
import UIKit

class CollectionViewCell : UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .gray
    }
    
    func config(memeData: MemeData) {
        imageView!.image = memeData.customizedImage
    }
}
