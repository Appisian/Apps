//
//  ModelController.swift
//  Shopping List – Mel-chan & Binh-kun
//
//  Created by Thanh-Binh TANG on 14/12/2016.
//  Copyright © 2016 Thanh-Binh TANG. All rights reserved.
//

import Foundation

class ModelController: NSObject {
    
    var items = Array<Item>()
    
    func addItem(name:String, amount:String, category:String, idCategory:Int, isChecked: Bool) {

        items.insert(Item(), at: 0)
        items.first!.name = name
        items.first!.amount = amount
        items.first!.category = category
        items.first!.idCategory = idCategory
        items.first!.isChecked = isChecked
        print(items)
    }
    
}
