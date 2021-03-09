//
//  TableViewController.swift
//  MemeMe 2.0
//
//  Created by Haeussermann, Tobias (059) on 08.03.21.
//

import Foundation
import UIKit

class TableViewController : UITableViewController {
    
    private let dataSource = TableViewDataSource()
    
    // MARK: ViewController callbacks
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUIElements()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: TableViewControllerDelegate callbacks
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showDetailViewController(memeIndex: indexPath.row)        // ext-func: 'utils.Extensions'
    }
    
    // MARK: Button actions
    
    @IBAction func showMemeEditor() {
        showMemeEditorViewController()     // ext-func: 'utils.Extensions'
    }
    
    // MARK: UI interaction
    
    private func configureUIElements() {
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.rowHeight = 100
        tableView.tableFooterView = UIView()
    }
    
}
