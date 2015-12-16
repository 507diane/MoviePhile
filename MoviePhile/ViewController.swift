//
//  ViewController.swift
//  MoviePhile
//
//  Created by Diane Christy on 11/9/15.
//  Copyright © 2015 Diane Christy. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UIPickerViewDelegate {
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate
    as! AppDelegate).managedObjectContext
    
    var moviedb:NSManagedObject!
     let pickerGenre = ["Pick One", "Drama","Mystery","Action","Comedy","Romance","Independent", "Musical"]
    var colorpicked:String?
    
    @IBOutlet weak var mname: UITextField!
    
    
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
            moviedb.setValue(mname.text, forKey: "name")
            moviedb.setValue(colorpicked, forKey: "genre")
            moviedb.setValue(year.text, forKey: "year")
            moviedb.setValue(location.text, forKey: "location")
            moviedb.setValue(info.text, forKey: "info")
        }
        else
        {
            let entityDescription =
            NSEntityDescription.entityForName("Movie", inManagedObjectContext: managedObjectContext)
            
            let movie = MovieMovie(entity: entityDescription!,
            insertIntoManagedObjectContext: managedObjectContext)
            
            movie.name = mname.text
            movie.genre = colorpicked
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

    
    //genre
    var selectedgenre:String!
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerGenre.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerGenre[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        colorpicked = pickerGenre[row]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        genre.delegate = self
        
        if (moviedb != nil)
        {
            mname.text = moviedb.valueForKey("name") as? String
            colorpicked = moviedb.valueForKey("genre") as? String
            year.text = moviedb.valueForKey("year") as? String
            location.text = moviedb.valueForKey("location") as? String
            info.text = moviedb.valueForKey("info") as? String
            btnSave.setTitle("Update Movies", forState: UIControlState.Normal)
            let SelectedColor:Int = (pickerGenre).indexOf(colorpicked!)!
            genre.selectRow(SelectedColor,inComponent: 0, animated: true)
        }
        else
        {
             mname.becomeFirstResponder()
        }
       
       
        
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "Dismiss Keyboard")
        
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
        override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
            if let touch = touches.first as UITouch! {
                DismissKeyboard()
            }
            super.touchesBegan(touches , withEvent:event)
        }

        func DismissKeyboard(){
            mname.endEditing(true)
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
extension UIWebView {
    func loadLocalPDF(name:String!) {
        //load local pdf
        let termsPath:String? = NSBundle.mainBundle().pathForResource(name, ofType: "pdf")!
        let url = NSURL(fileURLWithPath: termsPath!)
        let pdfRequest = NSURLRequest(URL: url)
        self.loadRequest(pdfRequest)
    }
    func loadExternalPDF(name:String!){
        let url = NSURL(string: name)
        let request = NSURLRequest(URL:url!)
        self.scalesPageToFit = true
        self.loadRequest(request)
    }
}





