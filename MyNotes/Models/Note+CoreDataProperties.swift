//
//  Note+CoreDataProperties.swift
//  MyNotes
//
//  Created by zedsbook on 10/12/2022.
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var id: UUID!
    @NSManaged public var text: String!
    @NSManaged public var lastUpdated: Date!
    @NSManaged public var image: Data!

}

extension Note : Identifiable {

}
