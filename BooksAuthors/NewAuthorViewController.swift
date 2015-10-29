//
//  NewAuthorViewController.swift
//  BooksAuthors
//
//  Created by Jaini,Santhoshi on 3/20/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

import CoreData

class NewAuthorViewController: UIViewController , UITextFieldDelegate{

  
  var  managedObjectContext  = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    
   
    @IBOutlet weak var SSNTF: UITextField!
    
    @IBOutlet weak var nameTF: UITextField!
    

    @IBOutlet weak var dobTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SSNTF.placeholder = "Enter SSN "
        dobTF.placeholder = "MM-DD-YYYY"
 
        nameTF.placeholder = "Enter Name"
        nameTF.delegate = self
        SSNTF.delegate = self
        dobTF.delegate = self
       

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func Done(sender: AnyObject) {
        var newAuthor = NSEntityDescription.insertNewObjectForEntityForName("Author",
            inManagedObjectContext: managedObjectContext!) as Author
        if !dobTF.text.isEmpty && !nameTF.text.isEmpty && !SSNTF.text.isEmpty {
            newAuthor.ssn = Int((SSNTF.text as NSString).integerValue)
            newAuthor.name = nameTF.text
            
            var dateString = dobTF.text
            var dateFormatter = NSDateFormatter()
            
            dateFormatter.dateFormat = "MM-dd-yyyy"
            
            var dateFromString = dateFormatter.dateFromString(dateString)
            
            newAuthor.dob = dateFromString!
            
            var error:NSError?
            managedObjectContext?.save(&error)
            self.dismissViewControllerAnimated(true  , completion: nil )
        }

    }
    
    @IBAction func Cancel(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true  , completion: nil )
    }
        
    
  
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        nameTF.resignFirstResponder()
        SSNTF.resignFirstResponder()
        dobTF.resignFirstResponder()
        
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
