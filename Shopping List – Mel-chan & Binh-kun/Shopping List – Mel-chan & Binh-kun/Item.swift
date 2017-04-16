//
//  localStorage.swift
//  Shopping List – Mel-chan & Binh-kun
//
//  Created by Thanh-Binh TANG on 15/12/2016.
//  Copyright © 2016 Thanh-Binh TANG. All rights reserved.
//

import Foundation

class Item {
    
    var name = ""
    var amount = ""
    var category = ""
    var idCategory = 0
    var isChecked = false
    
    func dictionary() -> NSDictionary {
        return NSDictionary.init(objects: [name, amount, category, idCategory, isChecked], forKeys: ["name" as NSString, "amount" as NSString, "category" as NSString, "idCategory" as NSString, "isChecked" as NSString])
    }
    
    class func itemWith(dictionary: NSDictionary) -> Item {
        let item = Item()
        item.name = dictionary.object(forKey: "name") as! String
        item.amount = dictionary.object(forKey: "amount") as! String
        item.category = dictionary.object(forKey: "category") as! String
        item.idCategory = dictionary.object(forKey: "idCategory") as! Int
        item.isChecked = dictionary.object(forKey: "isChecked") as! Bool
        
        return item
    }
}
