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
    
    static let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let key = "records"
    
    static func saveToFile(records: [Record]) {
        
        let propertyEncoder = PropertyListEncoder()
        if let data = try? propertyEncoder.encode(records) {
            
            // Method1: Document Directory
            let url = Record.documentDirectory.appendingPathComponent(key)
            try? data.write(to: url)
            
//            // Method2: UserDefaults
//            let userDefaults = UserDefaults.standard
//            userDefaults.set(data, forKey: key)
        }
    }
    
    static func readFromFile() -> [Record]? {
        let propertyDecoder = PropertyListDecoder()
        
        // Method1: Document Directory
        let url = Record.documentDirectory.appendingPathComponent(key)
        if let data = try? Data(contentsOf: url), let records = try? propertyDecoder.decode([Record].self, from: data) {
            return records
        } else {
            return nil
        }
        
//        // Method2: UserDefaults
//        let userDefaults = UserDefaults.standard
//        if let data = userDefaults.data(forKey: key), let records = try? propertyDecoder.decode([Record].self, from: data) {
//            return records
//        } else {
//            return nil
//        }
    }
    
    static func deleteFile() {
        do {
            let url = Record.documentDirectory.appendingPathComponent(key)
            try FileManager.default.removeItem(at: url)
        } catch {
            print(error.localizedDescription)
        }
    }
}


