//
//  ToDoListItem+CoreDataProperties.swift
//  toDoList
//
//  Created by Makape Tema on 2023/02/26.
//
//

import Foundation
import CoreData


extension ToDoListItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoListItem> {
        return NSFetchRequest<ToDoListItem>(entityName: "ToDoListItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var dueDate: Date?
    @NSManaged public var check: Bool
}

extension ToDoListItem : Identifiable {

}
