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
    
    override func viewDidLoad() {
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.rowHeight = 100
        tableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    @IBAction func showMemeEditor() {
        let editorViewController = storyboard?.instantiateViewController(identifier: "memeEditor") as! UINavigationController
        editorViewController.modalPresentationStyle = .fullScreen
        show(editorViewController, sender: self)
    }
    
}
