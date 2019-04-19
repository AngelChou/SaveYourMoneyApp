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
    
    var record: Record?
    var delegate: DetailTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let record = record {
            titleTextField.text = record.title
            costTextField.text = record.cost
            typeSegment.selectedSegmentIndex = record.type
        }
    }

    @IBAction func SaveButtonPressed(_ sender: Any) {
        if let title = titleTextField.text, let cost = costTextField.text {
            record = Record(title: title, cost: cost, type: typeSegment.selectedSegmentIndex)
            delegate?.update(record: record!)
            navigationController?.popViewController(animated: true)
        }
    }
    
}
