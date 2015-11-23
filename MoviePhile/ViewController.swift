//
//  ViewController.swift
//  MoviePhile
//
//  Created by Diane Christy on 11/9/15.
//  Copyright © 2015 Diane Christy. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate
    as! AppDelegate).managedObjectContext
    
    var moviedb:NSManagedObject!
    
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var genre: UIPickerView!
    
    
    @IBOutlet weak var year: UITextField!
    
    @IBOutlet weak var location: UITextField!
    
    @IBOutlet weak var info: UITextView!
    
    @IBOutlet weak var btnSave: UIButton!
    
    @IBAction func btnBack(sender: UIBarButtonItem) {
        
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    @IBAction func btnSave(sender: UIButton) {
        
        if (moviedb != nil)
        {
            moviedb.setValue(name.text, forKey: "name")
            moviedb.setValue(genre, forKey: "genre")
            moviedb.setValue(year, forKey: "year")
            moviedb.setValue(location, forKey: "location")
            moviedb.setValue(info, forKey: "info")
        }
        else
        {
            let entityDescription =
            NSEntityDescription.entityForName("Movie", inManagedObjectContext: managedObjectContext)
            
            let movie = Movie(entity: entityDescription!,
            insertIntoManagedObjectContext: managedObjectContext)
            
            movie.name = name.text
            movie.genre = genre.text
            movie.year = year.text
            movie.location = location.text
            movie.info = info.text
    
        }
        var error: NSError?
        do {
            try managedObjectContext.save()
        } catch let error1 as NSError {
            error = error1
        }
        
        if let err = error {
            info.text = err.localizedFailureReason
        } else {
            self.dismissViewControllerAnimated(false, completion: nil)
            
        }
        
    }

    @IBAction func btnSearch(sender: UIButton) {
        
        let entityDescription =
        NSEntityDescription.entityForName("Movie", inManagedObjectContext: managedObjectContext!)
        
        let request = NSFetchRequest()
        request.entity = entityDescription
        
        let pred = NSPredicate(format: "(name = %@)", name.text)
        request.predicate = pred
        
        var error: NSError?
        
        var objects = managedObjectContext?, excecuteFetchRequest(request, error: &error)
        
        if let results = objects {
            if results.count > 0 {
                let match = results[0] as NSManagedObject
                
                name.text = match.valueForKey("name") as String
                genre.text = match.valueForKey("genre") as String
                year.text = match.valueForKey("year") as String
                location.text = match.valueForKey("year") as String
                status.text = match.valueForKey("status") as String
                
            } else {
                status.text = "No Match"
            }
        }
        
        
        
    }
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (moviedb != nil)
        {
            name.text = moviedb.valueForKey("name") as? String
            genre.text = moviedb.valueForKey("genre") as? String
            year.text = moviedb.valueForKey("year") as? String
            location.text = moviedb.valueForKey("location") as? String
            info.text = moviedb.valueForKey("info") as? String
            btnSave.setTitle("Update Movies", forState: UIControlState.Normal)
        }
        name.becomeFirstResponder()
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "Dismiss Keyboard")
        
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
        override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
            if let touch = touches.first as UITouch! {
                DismissKeyboard()
            }
            super.touchesBegan(touches , withEvent:event)
        }

        func DismissKeyboard(){
            name.endEditing(true)
            genre.endEditing(true)
            year.endEditing(true)
            location.endEditing(true)
            info.endEditing(true)
        }
        
        func textFieldShouldReturn(textField: UITextField!) -> Bool {
            textField.resignFirstResponder()
            return true;
        }
        // Dispose of any resources that can be recreated.
    }


}

