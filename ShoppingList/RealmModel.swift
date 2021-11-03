//
//  RealmModel.swift
//  ShoppingList
//
//  Created by mac on 2021/11/04.
//

import Foundation
import RealmSwift

class ShoppingList:Object{
    @Persisted var title: String
    @Persisted var check: Int
    @Persisted var bookmark: Int
    
    
    @Persisted(primaryKey: true) var _id:ObjectId
    
    
    convenience init(title:String){
        self.init()
        
        self.title = title
        self.check = 0
        self.bookmark = 0
        
    }
    
}
