//
//  SpecificItemViewController.swift
//  TeamWFH_finalproject
//
//  Created by Alison Wilkes on 5/3/20.
//  Copyright © 2020 Alison Wilkes. All rights reserved.
//

import UIKit
//import CoreData

class SpecificItemViewController: UIViewController, DataProtocol {
    
    func responseError(message: String) {
        DispatchQueue.main.async() {
            print("error")
//            self.titleLabel.text = "Error!"
//            self.bodyTextView.text = message
        }
    }
    
//class SpecificItemViewController: UIViewController {

    @IBOutlet weak var specificItemTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var type = ""
    var typeRetrieve = DataSession()

    
    // nookipedia api connection
    var dataSession = DataSession()
    var bugs = [String: String]() // dictionary to hold the bug stuff
    var bugsKeys = Array<String>()
    //var bugs2 :[NSManagedObject] = [] // might do this in core data...
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = type
        typeRetrieve.itemType = type
        typeRetrieve.delegate = self
        let itemType = typeRetrieve.retrieving()
        //searchBar.delegate = (self as UISearchBarDelegate)
        self.dataSession.delegate = self
        self.dataSession.getData(itemURLType: itemType) // test
        //loadBugs()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    
     //MARK: Data Protocol
        
    func responseDataHandler(data:String){

        let content = data

        let sectionData = Array(content.components(separatedBy: "<section begin=")[1...])
        //print(sectionData) // this is an array of all the bugs... each item is one bug + all info on that bug


        sectionData.forEach { bug in
            // split each bugs info by \n character
            let bugData = Array(bug.components(separatedBy: "\n"))
            var name = bugData[0] // grab name
            name.removeLast(3) // remove the " />" on the names
            let data = Array(bugData[1...]) // grab associated data... doing it this way in case we want to get more than price
            var price = data[4] // grab the price
            price.removeFirst(2) // remove "| " in the prices
            bugs[name] = price // add to dictionary of all bug names and prices
            //addBug(name: name, price: price)

        }
        self.bugsKeys = Array(bugs.keys)
        print(bugsKeys)//bugsKeys needs to be global or something, it's empty in the extension. WORK HERE
    }
    
    func typeTransfer(data: String) {
       print(data)
    }
    
//    func addBug(name: String, price: String) {
//        let managedObject = appDelegate.persistentContainer.viewContext
//        let entity = NSEntityDescription.entity(forEntityName: "Bug", in:
//               managedObject)!
//        let newBug = NSManagedObject(entity: entity, insertInto: managedObject)
//        if (!someEntityExists(name: name)) {
//            // bug doesnt exist in core data yet
//            newBug.setValue(name, forKey: "name")
//            newBug.setValue(price, forKey:"price")
//
//
//            do {
//                try managedObject.save()
//
//            } catch {
//                let nserror = error as NSError
//                NSLog("Unable to save \(nserror), \(nserror.userInfo)")
//                abort()
//            }
//        }
//
//    }
    
//    func someEntityExists(name: String) -> Bool {
//        // checks to make sure the bug hasnt already been added to core data... idk if this is working right
//        let managedObjectContext = appDelegate.persistentContainer.viewContext
//        var fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Bug")
//        fetchRequest.predicate = NSPredicate(format: "name = %@", name)
//
//        var results: [NSManagedObject] = []
//
//        do {
//            results = try managedObjectContext.fetch(fetchRequest)
//        }
//        catch {
//            print("error executing fetch request: \(error)")
//        }
//
//        return results.count > 0
//    }
    
//    func loadBugs() {
//
//        //let result:[NSManagedObject];
//        bugs = [] // reset the array since we are reloading
//
//
//        //1
//        guard let appDelegate =
//            UIApplication.shared.delegate as? AppDelegate else {
//                return
//        }
//
//        let managedContext =
//            appDelegate.persistentContainer.viewContext
//
//        //2
//        let fetchRequest =
//            NSFetchRequest<NSManagedObject>(entityName: "Bug")
//
//        //3
//        do {
//            let result = try managedContext.fetch(fetchRequest)
//            for data in result {
//                let bug = data
//                bugs2.append(bug)
//            }
//        } catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//        }
//
//
//
//
//    }
//
//        func responseError(message:String) {
//            //Run this handling on a separate thread
//
//            DispatchQueue.main.async() {
//                print("error")
//    //            self.titleLabel.text = "Error!"
//    //            self.bodyTextView.text = message
//            }
//        }


}

extension SpecificItemViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return bugs2.count
        print(self.bugsKeys.count)
        return self.bugsKeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let bug = bugs2[indexPath.row]
        let cell = specificItemTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SpecificItemTableViewCell
        let name = bugsKeys[indexPath.row]
        print(name)
        let price = bugs[name]
        print(price!)
        cell!.nameLabel.text = name
        cell!.priceLabel.text = "\(String(describing: price)) bells"
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        vc?.name = bugsKeys[indexPath.row]
        vc?.price = bugs[bugsKeys[indexPath.row]]!
        //vc?.name = bugs2[indexPath.row]

        navigationController?.pushViewController(vc!, animated: true)
    }
    
    
}

//extension SpecificItemViewController : UISearchBarDelegate{//this is for the search bar
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        print("searchbar");
//    }
//}
