//
//  MovieMovie+CoreDataProperties.swift
//  MoviePhile
//
//  Created by Diane Christy on 11/30/15.
//  Copyright © 2015 Diane Christy. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension MovieMovie {

    @NSManaged var genre: String?
    @NSManaged var info: String?
    @NSManaged var location: String?
    @NSManaged var name: String?
    @NSManaged var year: String?

}
