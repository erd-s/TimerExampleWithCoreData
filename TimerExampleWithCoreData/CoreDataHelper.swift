//
//  CoreDataHelper.swift
//  TimerExampleWithCoreData
//
//  Created by Christopher Erdos on 1/24/17.
//  Copyright © 2017 Erdos. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataHelper {
	let moc: NSManagedObjectContext!
	let entityName = "ExampleEntity"
	var loggingRequested = false
	
	
	init(shouldLog: Bool) {
		if shouldLog { loggingRequested = true } else { loggingRequested = false }
		moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	}
	
	
	/**
	Get entity supports just getting the first entity returned in the request.
	Uncomment parameters to use any sort of matching.
	
	- returns: ExampleEntity or nil if none exist.
	*/
	func getEntity(/*withParameter: Any*/) -> ExampleEntity? {
		let entity = NSEntityDescription.entity(forEntityName: entityName, in: moc)
		let req = NSFetchRequest<NSFetchRequestResult>()
		req.entity = entity
		
		if let entities = try? moc.fetch(req) as? [ExampleEntity] {
			/*
			for entity in entities {
				if entity.parameter == parameter { return entity }
			}
			*/
			
			if loggingRequested {
				print("retrieved entity from moc")
				print(entities!.first!)
			}
			if entities!.count > 0 { return entities!.first } else { return nil }
		} else {
			if loggingRequested { print("could not retrieve entity from moc") }
			return nil
		}
	}
	
	/**
	Creates a new Core Data Entity that will be fetched and saved to later.
	*/
	func createEntity() -> ExampleEntity {
		let entity = NSEntityDescription.insertNewObject(forEntityName: entityName, into: moc) as! ExampleEntity
		entity.timeElapsed = 0
		
		if loggingRequested { print("created new entity") }
		save()
		return entity
	}
	
	/**
	Saves any changes to the managed object context.
	*/
	func save() {
		if moc.hasChanges {
			try! moc.save()
		}
	}
}
