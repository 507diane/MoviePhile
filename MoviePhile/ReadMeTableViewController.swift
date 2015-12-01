//
//  ReadMeTableViewController.swift
//  MoviePhile
//
//  Created by Diane Christy on 11/30/15.
//  Copyright © 2015 Diane Christy. All rights reserved.
//

import UIKit

class ReadMeTableViewController: UIViewController {
    
    
    @IBOutlet weak var webview: UIWebView!
    
    
    @IBAction func btnBack(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        LoadLocalPDF()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.}
    }
    
    func LoadLocalPDF()
    {
        webview.loadLocalPDF("readme")
        //webview.loadExternalPDF(("URL TO PDF")
}
    
}