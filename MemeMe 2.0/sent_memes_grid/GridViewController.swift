//
//  GridViewController.swift
//  MemeMe 2.0
//
//  Created by Haeussermann, Tobias (059) on 08.03.21.
//

import Foundation
import UIKit

class GridViewController : UICollectionViewController {
    
    private let dataSource = CollectionViewDataSource()
    private let margin = CGFloat(2)
    
    @IBOutlet private weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
        
        let length = (view.frame.width - 4 * margin) / 3.0
        
        flowLayout.minimumInteritemSpacing = margin
        flowLayout.minimumLineSpacing = margin
        flowLayout.itemSize = CGSize(width: length, height: length)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    @IBAction func showDetailView() {
        let editorViewController = storyboard?.instantiateViewController(identifier: "memeEditor") as! UINavigationController
        editorViewController.modalPresentationStyle = .fullScreen
        show(editorViewController, sender: self)
    }
}
