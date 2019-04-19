//
//  ListTableViewController.swift
//  SaveYourMoneyApp
//
//  Created by Shun-Ching, Chou on 2019/4/19.
//  Copyright © 2019 Shun-Ching, Chou. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController, DetailTableViewControllerDelegate {

    var records = [Record]()
    
    func update(record: Record) {
        if let indexPath = tableView.indexPathForSelectedRow {
            // 修改點選cell的資料內容
            records[indexPath.row] = record
            tableView.reloadRows(at: [indexPath], with: .automatic)
            Record.saveToFile(records: records)
        } else {
            // 新增一筆資料到第一列
            records.insert(record, at: 0)
            let newIndexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            Record.saveToFile(records: records)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let records = Record.readFromFile() {
            self.records = records
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordCellId", for: indexPath)

        // Configure the cell...
        let record = records[indexPath.row]
        cell.textLabel?.text = "\(record.title): \(record.cost)"
        if record.type == 0 {
            cell.textLabel?.textColor = .red
        } else {
            cell.textLabel?.textColor = .blue
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            records.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            Record.saveToFile(records: records)
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? DetailTableViewController {
            controller.delegate = self
            
            // 若是點選cell，則將cell的資料傳到過去
            if let row = tableView.indexPathForSelectedRow?.row {
                controller.record = records[row]
            }
        }
    }
    

}
