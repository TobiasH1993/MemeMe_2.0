//
//  DetailViewController.swift
//  MemeMe 2.0
//
//  Created by Haeussermann, Tobias (059) on 08.03.21.
//

import Foundation
import UIKit

class DetailViewController : UIViewController {
    
    @IBOutlet private weak var imageView: UIImageView!
    
    var image: UIImage!
    
    override func viewDidLoad() {
        imageView.image = image
    }
}
