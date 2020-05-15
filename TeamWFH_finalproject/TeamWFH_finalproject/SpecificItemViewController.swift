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
    
    var searchedCritter = [String]()
    @IBOutlet weak var specificItemTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var type = ""
    var typeRetrieve = DataSession()

    
    // nookipedia api connection
    var dataSession = DataSession()
    var bugs = [String: String]() // dictionary to hold the bug stuff
    public var bugsKeys = Array<String>()
    public var reverseDict = Array<String>()
    public var imgPathDict = [String: String]()
    public var timeDayDict = [String: String]()
    public var monthDict = [String: Array<String>]()
    //public var bugsImgURL = Array<String>()
    //var bugs2 :[NSManagedObject] = [] // might do this in core data...
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self

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
    
    var isSearchBarEmpty: Bool {
      return searchBar.text?.isEmpty ?? true
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
            
            if(type == "Fish"){
                // get time of day
                var time = data[9]
                time.removeFirst(2) // remove "| " in active times
                //print("time:",time)
                timeDayDict[name] = time
                
                // get seasonality
                var north = data[10]
                let northMos = north.components(separatedBy: "|") // 3 is start and 4 is end
                let nData  = northMos[3...]
                if (nData.count == 2) {
                    // only one start and end
                    var nStart = nData[3]
                    var nEnd = nData[4]
                    nStart.removeFirst(6)
                    nEnd.removeFirst(4)
                    nEnd.removeLast(2)
                    north = "\(nStart) - \(nEnd)"
                }
                if (nData.count == 4) {
                    // 2 start and end dates
                    var nStart1 = nData[3]
                    var nEnd1 = nData[4]
                    var nStart2 = nData[5]
                    var nEnd2 = nData[6]
                    nStart1.removeFirst(6)
                    nEnd1.removeFirst(4)
                    nStart2.removeFirst(7)
                    nEnd2.removeFirst(5)
                    nEnd2.removeLast(2)
                    north = "\(nStart1) - \(nEnd1), \(nStart2) - \(nEnd2)"
                }
                var south = data[11]
                let southMos = south.components(separatedBy: "|")
                let sData = southMos[2...]
                if (sData.count == 2) {
                    // only one start and end
                    var sStart = sData[2]
                    var sEnd = sData[3]
                    sStart.removeFirst(6)
                    sEnd.removeFirst(4)
                    sEnd.removeLast(2)
                    south = "\(sStart) - \(sEnd)"
                }
                if (sData.count == 4) {
                    // 2 start and end dates
                    var sStart1 = sData[2]
                    var sEnd1 = sData[3]
                    var sStart2 = sData[4]
                    var sEnd2 = sData[5]
                    sStart1.removeFirst(6)
                    sEnd1.removeFirst(4)
                    sStart2.removeFirst(7)
                    sEnd2.removeFirst(5)
                    sEnd2.removeLast(2)
                    south = "\(sStart1) - \(sEnd1), \(sStart2) - \(sEnd2)"
                }
                monthDict[name] = [north, south]
            }else{
                // get time of day
                var time = data[8]
                time.removeFirst(2) // remove "| " in active times
                //print("time:",time)
                timeDayDict[name] = time
                
                // get seasonality
                var north = data[9]
                let northMos = north.components(separatedBy: "|") // 3 is start and 4 is end
                let nData  = northMos[3...]
                if (nData.count == 2) {
                    // only one start and end
                    var nStart = nData[3]
                    var nEnd = nData[4]
                    nStart.removeFirst(6)
                    nEnd.removeFirst(4)
                    nEnd.removeLast(2)
                    north = "\(nStart) - \(nEnd)"
                }
                if (nData.count == 4) {
                    // 2 start and end dates
                    var nStart1 = nData[3]
                    var nEnd1 = nData[4]
                    var nStart2 = nData[5]
                    var nEnd2 = nData[6]
                    nStart1.removeFirst(6)
                    nEnd1.removeFirst(4)
                    nStart2.removeFirst(7)
                    nEnd2.removeFirst(5)
                    nEnd2.removeLast(2)
                    north = "\(nStart1) - \(nEnd1), \(nStart2) - \(nEnd2)"
                }
                var south = data[10]
                let southMos = south.components(separatedBy: "|")
                let sData = southMos[2...]
                if (sData.count == 2) {
                    // only one start and end
                    var sStart = sData[2]
                    var sEnd = sData[3]
                    sStart.removeFirst(6)
                    sEnd.removeFirst(4)
                    sEnd.removeLast(2)
                    south = "\(sStart) - \(sEnd)"
                }
                if (sData.count == 4) {
                    // 2 start and end dates
                    var sStart1 = sData[2]
                    var sEnd1 = sData[3]
                    var sStart2 = sData[4]
                    var sEnd2 = sData[5]
                    sStart1.removeFirst(6)
                    sEnd1.removeFirst(4)
                    sStart2.removeFirst(7)
                    sEnd2.removeFirst(5)
                    sEnd2.removeLast(2)
                    south = "\(sStart1) - \(sEnd1), \(sStart2) - \(sEnd2)"
                }
                monthDict[name] = [north, south]
            }
            
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
        //print(self.bugsKeys.count)
        if !isSearchBarEmpty {
            return searchedCritter.count
        } else {
            return self.bugsKeys.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //let bug = bugs2[indexPath.row]
        let cell = specificItemTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SpecificItemTableViewCell
        
        var name = ""
        if isSearchBarEmpty {
            name = bugsKeys[indexPath.row]}
        else{
            name = searchedCritter[indexPath.row]
        }
        
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
        vc?.timeDay = timeDayDict[bugsKeys[indexPath.row]]!
        vc?.months = monthDict[bugsKeys[indexPath.row]]!
        //vc?.name = bugs2[indexPath.row]

        navigationController?.pushViewController(vc!, animated: true)
    }

}

//extension SpecificItemViewController : UISearchBarDelegate{//this is for the search bar
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        print("searchbar");
//    }
//}
extension  SpecificItemViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //searchedCritter = bugsKeys.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
        
        searchedCritter = bugsKeys.filter{return $0.contains(searchText)}
        
        print(searchText)
        print(searchedCritter)
        print(bugsKeys)

        specificItemTableView.reloadData()
    }
    
}
