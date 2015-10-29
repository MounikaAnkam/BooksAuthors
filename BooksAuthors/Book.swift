//
//  Book.swift
//  BooksAuthors
//
//  Created by Jaini,Santhoshi on 3/20/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import Foundation
import CoreData
@objc(Book)
class Book: NSManagedObject {

    @NSManaged var title: String
    @NSManaged var price: NSNumber
    @NSManaged var isbn: NSNumber
    @NSManaged var bookToAuthor: Author

}
