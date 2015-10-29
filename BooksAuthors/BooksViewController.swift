//
//  BooksViewController.swift
//  BooksAuthors
//
//   Created by Jaini,Santhoshi on 3/20/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

import CoreData

class BooksViewController: UIViewController , UITableViewDataSource , UITableViewDelegate{
    
    var authors:[Author] = [Author]()
    var books:[Book] = [Book]()
    var error:NSError?
    var selectedRow:Int = 0
    
    var  managedObjectContext  = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    
    
    @IBOutlet weak var tableView1: UITableView!
    
    @IBOutlet weak var tableView2: UITableView!
    
    var count:Int = 0
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView2.reloadData()
  

        // Do any additional setup after loading the view.
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView.viewWithTag(1) != nil{
            return authors.count}else{
            if count != 0 {
                return books.count }else{ return 0}
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        if tableView.viewWithTag(1) != nil{
            
            var cell = UITableViewCell()
            
            cell = tableView1.dequeueReusableCellWithIdentifier("authors") as UITableViewCell
            
            cell.textLabel?.text = authors[indexPath.row].name
            
            var formatter: NSDateFormatter = NSDateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            let stringDate: String = formatter.stringFromDate(authors[indexPath.row].dob)
            cell.detailTextLabel?.text =  String(stringDate)
            
            
            return cell
            
        }else{
            
            if count != 0 {
                
                var cell = UITableViewCell()
                
                cell = tableView2.dequeueReusableCellWithIdentifier("books") as UITableViewCell
                
                cell.textLabel?.text = books[indexPath.row].title
                
                return cell
            }else{
                var cell = UITableViewCell()
                
                cell = tableView2.dequeueReusableCellWithIdentifier("books") as UITableViewCell
                cell.textLabel?.text = ""
                return cell
            }
            
        }
        
    }
    
        
    
    override func viewWillAppear(animated: Bool) {
        self.view.viewWithTag(2)?.reloadInputViews()
        count = 0
        books = [Book]()
//        
        var fetchRequest = NSFetchRequest(entityName:"Author")
        authors = managedObjectContext?.executeFetchRequest(fetchRequest, error: &error) as [Author]
        self.tableView2.reloadData()
        self.tableView1.reloadData()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
      
        
        if tableView1.indexPathForSelectedRow()?.row != nil {
            
        count++
            self.tableView2.reloadData()
            books = [Book]()
         //   println(authors[indexPath.row].name)
            
        var fetchAuthor = NSFetchRequest(entityName: "Author")
        fetchAuthor.predicate = NSPredicate(format: "name = %@", authors[indexPath.row].name)
        var authorReq:[Author] = managedObjectContext?.executeFetchRequest(fetchAuthor, error: nil) as [Author]
            
            for bookRecord in authorReq[0].authorToBook{
            books.append(bookRecord as Book)
            }
            

        self.tableView2.reloadData()
        
     
        }
       
    }
    
    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        
        selectedRow = indexPath.row
 
      
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView.viewWithTag(1) != nil{
        return "Authors "}else{ return "Books"
            
        }
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
       
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "newbook"{
            
            (self.view.viewWithTag(2) as UITableView).reloadData()
            
            var nbvc = segue.destinationViewController as NewBookViewController
            
            var fetchRequest = NSFetchRequest(entityName: "Author")
            
            var requiredAuthor:Author!
            
            var authorList = managedObjectContext?.executeFetchRequest(fetchRequest, error: nil ) as [Author]
            
            for authorRecord in authorList {
                
                if self.tableView1.indexPathForSelectedRow() != nil {
                if authorRecord.name == authors[self.tableView1.indexPathForSelectedRow()!.row].name {
                    
                    println(authors[self.tableView1.indexPathForSelectedRow()!.row].name)
                    
                    requiredAuthor = authorRecord
                    nbvc.selectedAuthor = requiredAuthor
                    
                    }}
                
                else{
               
                    if authorRecord.name == authors[selectedRow].name {
                        
                        requiredAuthor = authorRecord
                        nbvc.selectedAuthor = requiredAuthor
                        
                    }
                
                
                
                }
            }
            
            
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
