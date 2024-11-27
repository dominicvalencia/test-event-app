//
//  Event.swift
//  TestApp
//
//  Created by Domini Valencia on 11/25/24.
//


import Foundation
import RealmSwift

protocol RealmFetchable {
    static func fetchAll() -> Results<Event>
}

class Event: Object, RealmFetchable {
    static func fetchAll() -> RealmSwift.Results<Event> {
        let realm = try! Realm()
        return realm.objects(Event.self)
    }
    
    @objc dynamic var id: String = ""
    @objc dynamic var buttonId: Int = 0
    @objc dynamic var timestamp: Date = Date()
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
