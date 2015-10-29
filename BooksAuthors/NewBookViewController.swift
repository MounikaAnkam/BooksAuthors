//
//  NewBookViewController.swift
//  BooksAuthors
//
//  Created by Jaini,Santhoshi on 3/20/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

import CoreData

class NewBookViewController: UIViewController , UITextFieldDelegate {
    
    var selectedAuthor:Author!
    
    var managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
  
    
    @IBOutlet weak var titleTF: UITextField!
    
    @IBOutlet weak var priceTF: UITextField!
    
    
    @IBOutlet weak var isbnTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTF.placeholder = "Enter Title"
        isbnTF.placeholder = "Enter ISBN"
        priceTF.placeholder = "Enter Price"
        
        isbnTF.delegate = self
        titleTF.delegate = self
        priceTF.delegate = self
 
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func Cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true  , completion: nil )
    }
    
  
    
    @IBAction func Done(sender: AnyObject) {
        
        if !isbnTF.text.isEmpty && !priceTF.text.isEmpty && !titleTF.text.isEmpty {
            
            var book = NSEntityDescription.insertNewObjectForEntityForName("Book", inManagedObjectContext: managedObjectContext!) as Book
            
            book.isbn = (isbnTF.text as NSString).integerValue
            book.price = (priceTF.text as NSString).doubleValue
            
            book.title = titleTF.text
            book.bookToAuthor = selectedAuthor
            
            managedObjectContext?.save(nil)
            self.dismissViewControllerAnimated(true  , completion: nil )
        }

    }
    
       func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        isbnTF.resignFirstResponder()
        titleTF.resignFirstResponder()
        priceTF.resignFirstResponder()
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
