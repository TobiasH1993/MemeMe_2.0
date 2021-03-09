//
//  CollectionViewController.swift
//  MemeMe 2.0
//
//  Created by Haeussermann, Tobias (059) on 08.03.21.
//

import Foundation
import UIKit

class CollectionViewController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var dataSource: CollectionViewDataSource!
    private let margin = CGFloat(2)
    
    @IBOutlet private weak var flowLayout: UICollectionViewFlowLayout!
    
    // MARK: ViewController callbacks
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUIElements()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    // MARK: CollectionViewControllerDelegate callbacks
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return calculateItemSize()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showDetailViewController(memeIndex: indexPath.row)        // ext-func: 'utils.Extensions'
    }
    
    // MARK: Button actions
    
    @IBAction func showMemeEditor() {
         showMemeEditorViewController()     // ext-func: 'utils.Extensions'
    }
    
    // MARK: UI interaction
    
    private func configureUIElements() {
        dataSource = CollectionViewDataSource()
        
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        
        flowLayout.minimumInteritemSpacing = margin
        flowLayout.minimumLineSpacing = margin
    }
    
    private func calculateItemSize() -> CGSize {
        let itemsPerRow: CGFloat = UIDevice.current.orientation.isLandscape ? 5.0 : 3.0
        let length = (view.frame.size.width - (itemsPerRow + 1.0) * margin) / itemsPerRow
        return CGSize(width: length, height: length)
    }
    
}
