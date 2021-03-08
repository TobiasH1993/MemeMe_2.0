//
//  TableViewDataSource.swift
//  MemeMe 2.0
//
//  Created by Haeussermann, Tobias (059) on 08.03.21.
//

import Foundation
import UIKit

class TableViewDataSource : NSObject, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = (UIApplication.shared.delegate as! AppDelegate).memes.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let memes = (UIApplication.shared.delegate as! AppDelegate).memes
        
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "memeCell", for: indexPath) as! TableViewCell
        tableCell.config(memeData: memes[indexPath.row])
        return tableCell
    }
    
}
