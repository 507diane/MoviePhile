//
//  Movie+CoreDataProperties.swift
//  MoviePhile
//
//  Created by Diane Christy on 11/16/15.
//  Copyright © 2015 Diane Christy. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Movie {

    @NSManaged var title: String?
    @NSManaged var genre: String?
    @NSManaged var year: String?
    @NSManaged var location: String?
    @NSManaged var info: String?

}
