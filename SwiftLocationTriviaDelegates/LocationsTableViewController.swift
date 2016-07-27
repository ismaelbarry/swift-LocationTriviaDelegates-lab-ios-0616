//
//  LocationsTableViewController.swift
//  SwiftLocationTriviaDelegates
//
//  Created by Ismael Barry on 7/26/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class LocationsTableViewController: UITableViewController, AddLocationViewControllerDelegate {

    var locationsArray = [Location]()
    
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
    
    @IBAction func addNavigationButtonDidTouchUpInside(sender: AnyObject) {
        
    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.locationsArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("locationsCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = self.locationsArray[indexPath.row].name
        
        return cell
    }
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let destinationVC = segue.destinationViewController as! AddLocationViewController
        
        if segue.identifier == "addLocationSegue" {
            
            // allows us to pass good data without explicitly setting properties in one view controller and setting it equal in the next view controller. From LocationsTableViewController, we will access the delegate, set it equal to self, and the functions will allow the delegate functions to pass data in between.
            destinationVC.delegate = self
        }
    }
    
    
    // MARK: - AddLocationsTableViewController Delegate Methods:
    
    // Is called when cancelbutton is tapped:
    func addLocationViewControllerDidCancel(viewController: AddLocationViewController) {
        
        // Note that it is standard for a view controller like this to not dismiss itself upon completion -- rather, that is the responsibility of the delegate. A view controller cannot know for certain how it was presented (i.e., modally or pushed onto a navigation stack), so it is best to leave the details of that up to the presenting view controller (in this case, LocationsTableViewController.
        
        // Since we presented the viewController modally and it is embedded in a navigation controller, we dismiss the viewcontroller this way. Rather than using self.dismissViewController(animated: true, completion: nil).
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    // Should return true only if the location name is unique.
    func addLocationViewController(viewController: AddLocationViewController, shouldAllowLocationName name: String) -> Bool {
     
        for locations in locationsArray {
            
            if locations.name == name {
                return false
            }
        }
        
        return true
    }
    
    // Should create a new Location object and add it to LocationsTableViewController's array of locations.
    func addLocationViewController(viewController: AddLocationViewController, didAddLocationName name: String) {
        
        self.locationsArray.append(Location(name: name, trivia: []))
        
        // Note that it is standard for a view controller like this to not dismiss itself upon completion -- rather, that is the responsibility of the delegate. A view controller cannot know for certain how it was presented (i.e., modally or pushed onto a navigation stack), so it is best to leave the details of that up to the presenting view controller (in this case, LocationsTableViewController.
        
        // Since we presented the viewController modally and it is embedded in a navigation controller, we dismiss the viewcontroller this way. Rather than using self.dismissViewController(animated: true, completion: nil).
        self.navigationController?.popViewControllerAnimated(true)

        self.tableView.reloadData()
    }
    

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
