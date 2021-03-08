//
//  TableViewCell.swift
//  MemeMe 2.0
//
//  Created by Haeussermann, Tobias (059) on 08.03.21.
//

import Foundation
import UIKit

class TableViewCell : UITableViewCell {
    
    private let verticalMargin = CGFloat(2)
    private let horizontalMargin = CGFloat(20)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView!.frame = createRect(leftRect: true)
        imageView!.contentMode = .scaleAspectFit
        imageView!.backgroundColor = .darkGray
        
        textLabel!.frame = createRect(leftRect: false)
    }
    
    private func createRect(leftRect: Bool) -> CGRect {
        let x = leftRect ? self.frame.origin.x : self.frame.width / 2 + horizontalMargin
        let width = leftRect ? self.frame.width / 2 : self.frame.width / 2 - 2 * horizontalMargin
        return CGRect(x: x, y: verticalMargin, width: width, height: self.frame.height - 2 * verticalMargin)
    }
    
    func config(memeData: MemeData) {
        imageView!.image = memeData.customizedImage
        textLabel!.text = "\(memeData.topText) \(memeData.bottomText)"
    }
}
