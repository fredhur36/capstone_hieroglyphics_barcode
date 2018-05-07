//
//  BackTableVC.swift
//  CBarcode
//
//  Created by Se Jin Lee on 18/03/2018.
//  Copyright © 2018 Se Jin Lee. All rights reserved.
//

import Foundation
class BackTableVC: UITableViewController
{
    var TableArray = [String]()
    override func viewDidLoad() {
        TableArray = ["hello", "second", "world"]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text=TableArray[indexPath.row]
        
        return cell
    }
}
