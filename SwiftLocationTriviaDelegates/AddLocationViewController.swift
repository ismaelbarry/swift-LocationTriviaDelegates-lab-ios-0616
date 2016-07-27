//
//  AddLocationViewController.swift
//  SwiftLocationTriviaDelegates
//
//  Created by Ismael Barry on 7/26/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class AddLocationViewController: UIViewController {

    @IBOutlet weak var addLocationTextField: UITextField!
    @IBOutlet weak var saveButtonOutlet: UIBarButtonItem!
    @IBOutlet weak var cancelButtonOutlet: UIBarButtonItem!
    
    // Add a weak property of type AddLocationViewControllerDelegate to AddLocationViewController called delegate. For memory management reasons, delegate properties should almost always be weak
    weak var delegate : AddLocationViewControllerDelegate? // allows us to pass good data without explicitly setting properties in one view controller and setting it equal in the next view controller. From LocationsTableViewController, we will access the delegate, set it equal to self, and the functions will allow the delegate functions to pass data in between.
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.saveButtonOutlet.enabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelNavigationButtonDidTouchUpInside(sender: AnyObject) {
    
        // Call the delegate method from the previous Controller (LocationsTableViewController) and send in self, since we want to dismiss the viewController that we are currently in.
        delegate?.addLocationViewControllerDidCancel(self)
    }

    @IBAction func saveNavigationButtonDidTouchUpInside(sender: AnyObject) {
    
        // When the save button is clicked, we add the location in the textField to the locationsArray in the LocationsTableViewController.
        delegate?.addLocationViewController(self, didAddLocationName: self.addLocationTextField.text!)
        
    }
    
    @IBAction func textFieldEditing(sender: AnyObject) {
        
        // If we are allowed to add a location, then we set the save button to active.
        if self.delegate?.addLocationViewController(self, shouldAllowLocationName: self.addLocationTextField.text!) == true {
            
            self.saveButtonOutlet.enabled = true
            
        } else {
            
            self.saveButtonOutlet.enabled = false
        }
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

// Create a custom protocol for the delegate of the AddLocationViewController class. Make sure to include the class keyword after the protocol declaration. This indicates that the protocol we just created can only be adopted by classes (not structs or enums) - we do this is for memory management reasons.
protocol AddLocationViewControllerDelegate: class {
    
    // Since our LocationsTableViewController adopts the AddLocationViewControllerDelegate protocol, it could potentially be the delegate for multiple different AddLocationViewControllerss. Due to this, these delegate protocol functions would each ideally take at least one argument - an argument for the sender (in this case, an AddLocationViewController. The latter two functions should also take the submitted location name as an argument.
    
    // A function that alerts the delegate that the user has tapped 'Cancel' on the AddLocationViewController.
    func addLocationViewControllerDidCancel(viewController: AddLocationViewController)
    
    // A function that asks the delegate if the submitted location name is valid. This function should enforce that there are no duplicate location names.
    func addLocationViewController(viewController: AddLocationViewController, shouldAllowLocationName name:String) -> Bool
    
    // A function that alerts the delegate that the user has confirmed their new location name.
    func addLocationViewController(viewController: AddLocationViewController, didAddLocationName name:String)
}