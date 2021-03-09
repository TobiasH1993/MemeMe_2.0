//
//  Extensions.swift
//  MemeMe 2.0
//
//  Created by Haeussermann, Tobias (059) on 09.03.21.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showDetailViewController(memeIndex: Int) {
        let memes = (UIApplication.shared.delegate as! AppDelegate).memes
        let detailViewController = storyboard?.instantiateViewController(identifier: "detailView") as! DetailViewController
        detailViewController.image = memes[memeIndex].customizedImage
        show(detailViewController, sender: self)
    }
    
    func showMemeEditorViewController() {
        let editorViewController = storyboard?.instantiateViewController(identifier: "memeEditor") as! UINavigationController
        editorViewController.modalPresentationStyle = .fullScreen
        show(editorViewController, sender: self)
    }
    
}
