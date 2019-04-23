//
//  DetailTableViewController.swift
//  SaveYourMoneyApp
//
//  Created by Shun-Ching, Chou on 2019/4/19.
//  Copyright © 2019 Shun-Ching, Chou. All rights reserved.
//

import UIKit

protocol DetailTableViewControllerDelegate {
    func update(record: Record)
}

class DetailTableViewController: UITableViewController {
    @IBOutlet weak var typeSegment: UISegmentedControl!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var costTextField: UITextField!
    
    var delegate: DetailTableViewControllerDelegate?
    var record: Record?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let record = record {
            titleTextField.text = record.title
            costTextField.text = record.cost
            typeSegment.selectedSegmentIndex = record.type
        }
    }

    @IBAction func SaveButtonPressed(_ sender: Any) {
        //收起鍵盤
        self.view.endEditing(true)
        
        //檢查所有欄位
        if titleTextField.text?.isEmpty == false,
            costTextField.text?.isEmpty == false,
            let title = titleTextField.text,
            let cost = costTextField.text {
            
            record = Record(title: title, cost: cost, type: typeSegment.selectedSegmentIndex)
            delegate?.update(record: record!)
            navigationController?.popViewController(animated: true)
        } else {
            let alertController = UIAlertController(title: "Oops", message: "有資料還沒輸入哦", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
}
