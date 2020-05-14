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
    public var bugsKeys = Array<String>()
    public var imgPathDict = [String: String]()
    //public var bugsImgURL = Array<String>()
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
            let forImage = name.components(separatedBy: " ") //this and the next line are for making the strings have - for names
            let joinForImage = forImage.joined(separator: "-")
            if(type == "Fish"){
                imgPathDict[name] = "70px-" + joinForImage + "-NH-Icon"
            } else{
                imgPathDict[name] = "64px-" + joinForImage + "-NH-Icon"
            }
            let data = Array(bugData[1...]) // grab associated data... doing it this way in case we want to get more than price
            //print("data:", data)
            var price = data[4] // grab the price
            price.removeFirst(2) // remove "| " in the prices
            bugs[name] = price // add to dictionary of all bug names and prices
            //addBug(name: name, price: price)

        }
        self.bugsKeys = Array(bugs.keys)
        //print("first count:", bugsKeys.count)
        //print(bugs.keys) // debug
        //print(bugsKeys)//bugsKeys needs to be global or something, it's empty in the extension. WORK HERE
        DispatchQueue.main.async {
            // this is the part that fixed the empty dictionary problem
            self.specificItemTableView.reloadData()
        }
        
    }
    
    func typeTransfer(data: String) {
       //print(data)
    }
    
}

extension SpecificItemViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.bugsKeys.count)
        return self.bugsKeys.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //let bug = bugs2[indexPath.row]
        let cell = specificItemTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SpecificItemTableViewCell
        let name = bugsKeys[indexPath.row]
        //print(name)
        let imgPath = imgPathDict[name]!
        let price = bugs[name]
        //print(price!)
        cell!.itemImage.image = UIImage(named: imgPath)
        cell!.nameLabel.text = name
        cell!.priceLabel.text = "\(String(describing: price!)) bells"
        return cell!

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        
        vc?.imgPath = imgPathDict[bugsKeys[indexPath.row]]!
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
