//
//  Note+CoreDataClass.swift
//  MyNotes
//
//  Created by zedsbook on 10/12/2022.
//

import Foundation
import CoreData

@objc(Note)
public class Note: NSManagedObject {
    var title: String {
        return text.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: .newlines).first ?? ""
    }
    
    var desc: String {
        return "\(lastUpdated.format())"
    }
}
