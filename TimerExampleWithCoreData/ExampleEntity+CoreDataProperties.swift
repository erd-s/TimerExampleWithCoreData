//
//  ExampleEntity+CoreDataProperties.swift
//  TimerExampleWithCoreData
//
//  Created by Christopher Erdos on 1/24/17.
//  Copyright © 2017 Erdos. All rights reserved.
//

import Foundation
import CoreData


extension ExampleEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExampleEntity> {
        return NSFetchRequest<ExampleEntity>(entityName: "ExampleEntity");
    }

    @NSManaged public var timeElapsed: Int64
    @NSManaged public var ref_date: NSDate?

}
