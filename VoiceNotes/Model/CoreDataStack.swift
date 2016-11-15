//
//  CoreDataStack.swift
//  VoiceNote
//
//  Created by Frain on 15/11/2016.
//  Copyright © 2016 Frain. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
	
	// MARK: - Core Data stack
	
	let persistentContainer: NSPersistentContainer
	
	private init() {
		let container = NSPersistentContainer(name: "VoiceNotes")
		container.loadPersistentStores { _ = $1.map { fatalError("Unresolved error \($0)") } }
		self.persistentContainer = container
	}
	
	// MARK: - Core Data Saving support
	
	static func saveContext() {
		if self.context.hasChanges {
			do {
				try self.context.save()
			} catch {
				print("Unresolved error \(error)")
			}
		}
	}
	
	static let shared = CoreDataStack()
	static var context: NSManagedObjectContext {
		return shared.persistentContainer.viewContext
	}
}
