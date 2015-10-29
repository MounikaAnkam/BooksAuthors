//
//  Author.swift
//  BooksAuthors
//
//  Created by Jaini,Santhoshi on 3/20/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import Foundation
import CoreData
@objc(Author)
class Author: NSManagedObject {

    @NSManaged var ssn: NSNumber
    @NSManaged var name: String
    @NSManaged var dob: NSDate
    @NSManaged var authorToBook: NSSet

}
