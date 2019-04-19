//
//  Record.swift
//  SaveYourMoneyApp
//
//  Created by Shun-Ching, Chou on 2019/4/19.
//  Copyright © 2019 Shun-Ching, Chou. All rights reserved.
//

import Foundation

struct Record: Codable {
    var title: String
    var cost: String
    var type: Int
    
    static func saveToFile(records: [Record]) {
        let propertyEncoder = PropertyListEncoder()
        if let data = try? propertyEncoder.encode(records) {
            let userDefaults = UserDefaults.standard
            userDefaults.set(data, forKey: "records")
        }
    }
    
    static func readFromFile() -> [Record]? {
        let userDefaults = UserDefaults.standard
        let propertyDecoder = PropertyListDecoder()
        if let data = userDefaults.data(forKey: "records"), let records = try? propertyDecoder.decode([Record].self, from: data) {
            return records
        } else {
            return nil
        }
    }
}


