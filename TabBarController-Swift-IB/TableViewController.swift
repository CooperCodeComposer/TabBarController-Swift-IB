//
//  FirstViewController.swift
//  TabBarController-Swift-IB
//
//  Created by Alistair Cooper on 5/3/16.
//  Copyright © 2016 Alistair Cooper. All rights reserved.
//

import UIKit

enum AmazonError: ErrorType {
    case FileNotFound
    case MakingArrayFailed
}

class TableViewController: UITableViewController {
        
    var items: Array = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "film music"
        
        do {
            items = try makeArrayFromCSV()
            
        } catch AmazonError.MakingArrayFailed {
            
        } catch {
            // catch other errors?
        }
        
        print(items)

    }
    
    func makeArrayFromCSV() throws -> Array<String> {
        
        let url = NSURL(string: "https://s3-us-west-2.amazonaws.com/iosassignment4/favfilmcomposers.csv")!
        
        do {
            let amazon = try String(contentsOfURL: url, encoding: NSUTF8StringEncoding)
            items = amazon.componentsSeparatedByString(",")
            
        } catch {
            throw AmazonError.FileNotFound
            
        }
        
        return items
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("composerCell", forIndexPath: indexPath)
        cell.textLabel!.text = items[indexPath.row]
        
        return cell
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let controller = segue.destinationViewController as! DetailViewController
                
                let composerName = items[indexPath.row]
                
                // get composer URL
                controller.url = makeComposerUrl(composerName)
            }
        }
    }
    
    func makeComposerUrl(composerName: String) -> String {
        
        var url: String = ""
        
        if composerName == "Harry Gregson Williams" {
            url = "http://www.imdb.com/name/nm0004581/?ref_=nv_sr_1"
            
        } else if composerName == "Alexandre DeSplat" {
            
            url = "http://www.imdb.com/name/nm0006035/?ref_=nv_sr_1"
        } else if composerName == "John Williams" {
            
            url = "http://www.imdb.com/name/nm0002354/?ref_=nv_sr_1"
        } else if composerName == "Cliff Martinez" {
            
            url = "http://www.imdb.com/name/nm0553498/?ref_=nv_sr_1"
        } else if composerName == "John Powell" {
            
            url = "http://www.imdb.com/name/nm0694173/?ref_=fn_al_nm_1"
        } else if composerName == "James Newton Howard" {
            
            url = "http://www.imdb.com/name/nm0006133/?ref_=nv_sr_1"
        } else if composerName ==  "Danny Elfman" {
            
            url = "http://www.imdb.com/name/nm0000384/?ref_=nv_sr_1"
        } else if composerName == "Bernard Hermann" {
            
            url = "http://www.imdb.com/name/nm0002136/?ref_=nv_sr_1"
        } else if composerName == "Thomas Newman" {
            
            url = "http://www.imdb.com/name/nm0002353/?ref_=nv_sr_1"
        }
        
        return url
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

