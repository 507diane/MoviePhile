//
//  MovieTableViewController.swift
//  MoviePhile
//
//  Created by Diane Christy on 11/16/15.
//  Copyright © 2015 Diane Christy. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class MovieTableViewController: UITableViewController {
    
    var movieArray = [NSManagedObject]()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        loaddb()
        
    }
    
    func loaddb(){
        
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Movie")
        
        var error: NSError?
        
        
        do {
            let fetchedResults = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
            if let results = fetchedResults {
                movieArray = results
                tableView.reloadData()
            
            } else {
                
                print("Could not fetch \(error,) \(error!.userInfo)")
            }
            
            } catch let error as NSError {
                // failure
                print("Fetch failed: \(error.localizedDescription)")
            }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieArray.count
    
        //return 0
    }
    
    

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
            as UITableViewCell!
        
        let person = movieArray[indexPath.row]
        cell.textLabel?.text = person.valueForKey("name") as! String?
        cell.detailTextLabel?.text = ">>"

        // Configure the cell...

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Return false if you do not want the specified item to be editable.
        print("You selected cell #\(indexPath)")
    }
    

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath: NSIndexPath) -> Bool {
        return true
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, commitEditingStyle: UITableViewCellEditingStyle,forRowAtIndexPath: NSIndexPath) {
        
        if editingStyle == .Delete {
            let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
            let context = appDelegate.managedObjectContext
            context.deleteObject(movieArray[indexPath.row])
            var error: NSError? = nil
            do {
                try context.save()
                loaddb()
            } catch let error1 as NSError {
                error = error1
                print("Unresolved error \(error)")
                abort()
            }
        }

    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "UpdateMovies" {
            if let destination = segue.destinationViewController as?
                ViewController {
                    if let SelectIndex = tableView.indexPathForSelectedRow?.row {
                        
                        let selectedDevice:NSManagedObject = movieArray[SelectIndex] as NSManagedObject
                        destination.moviedb = selectedDevice
                    }
            }
        }
    }
    

}
