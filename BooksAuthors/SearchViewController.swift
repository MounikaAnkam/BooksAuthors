//
//  SearchViewController.swift
//  BooksAuthors
//
//  Created by Vanamala,Sairam Prasad on 3/19/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import CoreData

class SearchViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {
    
    var managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    
    
    var bookList = [Book]()
    
    @IBOutlet weak var titleTF: UITextField!
    
    
    @IBOutlet weak var tableview: UITableView!
 
    
    @IBOutlet weak var searchSwitch: UISwitch!
 
    
    @IBAction func fetch(sender: AnyObject) {
        
        var fetchRequest = NSFetchRequest(entityName: "Book")
        
        if searchSwitch.on == true {
          fetchRequest.predicate = NSPredicate(format: "title contains %@" , titleTF.text)
        }
        else{
            fetchRequest.predicate = NSPredicate(format: "title = %@" , titleTF.text)
        }
   
        
        bookList = managedObjectContext?.executeFetchRequest(fetchRequest, error: nil ) as [Book]
        
        self.tableview.reloadData()
        
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        bookList  = [Book]()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableview.dequeueReusableCellWithIdentifier("search") as UITableViewCell
        cell.textLabel?.text = bookList[indexPath.row].title
        
        print("hi")
        
        return cell
        
    }
  
     func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String("Books Found: \(bookList.count)")
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
