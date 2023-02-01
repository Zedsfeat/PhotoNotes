//
//  ListNotesDelegate.swift
//  MyNotes
//
//  Created by zedsbook on 10/12/2022.
//

import Foundation


protocol ListNotesDelegate: AnyObject {
    func refreshNotes()
    func deleteNote(with id: UUID)
}
