//
//  WordData+CoreDataProperties.swift
//  project_uas
//
//  Created by Garry on 14/02/21.
//  Copyright © 2021 Garry. All rights reserved.
//
//

import Foundation
import CoreData


extension WordData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WordData> {
        return NSFetchRequest<WordData>(entityName: "WordData")
    }

    @NSManaged public var pronunciation: String?
    @NSManaged public var word: String?
    @NSManaged public var definitons: NSSet?
    
    public var toArray : [DefModeld]{
        let change = definitons as? Set<DefModeld> ?? []
        return change.reversed()
    }

}

// MARK: Generated accessors for definitons
extension WordData {

    @objc(addDefinitonsObject:)
    @NSManaged public func addToDefinitons(_ value: DefModeld)

    @objc(removeDefinitonsObject:)
    @NSManaged public func removeFromDefinitons(_ value: DefModeld)

    @objc(addDefinitons:)
    @NSManaged public func addToDefinitons(_ values: NSSet)

    @objc(removeDefinitons:)
    @NSManaged public func removeFromDefinitons(_ values: NSSet)

}
