//
//  Person+CoreDataProperties.swift
//  CoreDataExample
//
//  Created by M1 on 12.09.2022.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var birthDate: Date?

}

extension Person : Identifiable {

}
