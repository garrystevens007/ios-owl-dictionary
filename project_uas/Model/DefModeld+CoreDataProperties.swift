//
//  DefModeld+CoreDataProperties.swift
//  project_uas
//
//  Created by Garry on 14/02/21.
//  Copyright © 2021 Garry. All rights reserved.
//
//

import Foundation
import CoreData


extension DefModeld {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DefModeld> {
        return NSFetchRequest<DefModeld>(entityName: "DefModeld")
    }

    @NSManaged public var definition: String?
    @NSManaged public var emoji: String?
    @NSManaged public var example: String?
    @NSManaged public var image_url: String?
    @NSManaged public var type: String?
    @NSManaged public var wordData: WordData?

}
