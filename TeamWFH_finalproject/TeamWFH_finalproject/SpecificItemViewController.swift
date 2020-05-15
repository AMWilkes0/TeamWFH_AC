//
//  SpecificItemViewController.swift
//  TeamWFH_finalproject
//
//  Created by Alison Wilkes on 5/3/20.
//  Copyright © 2020 Alison Wilkes. All rights reserved.
//

import UIKit
import CoreData

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
    
    // what if we just store all the data into one dictionary so its {name: {price: $$, image: img, times: time, months: months, fave: boolean}}
    // only show faves offline and therefore only store coredata for those that are faved?
    var faves :[NSManagedObject] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var goToFave = false
    
    //var specificCell = SpecificItemTableViewCell() //test
    

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self

        self.title = type
        typeRetrieve.itemType = type
        typeRetrieve.delegate = self
        let itemType = typeRetrieve.retrieving()
        loadFaves()
        //searchBar.delegate = (self as UISearchBarDelegate)
        self.dataSession.delegate = self
        self.dataSession.getData(itemURLType: itemType) // test
        //loadBugs()
        //self.specificCell.delegate = self //test

        
        
        print(faves)
        //resetAllRecords()
        
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
        // try to switch bugsKeys now to favorites
        
        
        //print("first count:", bugsKeys.count)
        //print(bugs.keys) // debug
        //print(bugsKeys)//bugsKeys needs to be global or something, it's empty in the extension. WORK HERE
        DispatchQueue.main.async {
            // this is the part that fixed the empty dictionary problem
            if (self.title == "Favorites") {
                self.goToFave = true
                self.switchToFaves()
            }
            self.specificItemTableView.reloadData()
        }
        
    }
    
    func typeTransfer(data: String) {
       print(data)
        
        // if the type is Favorites can i switch the bugsKeys to be the fave dict here
        
    }
    func resetAllRecords() // entity = Your_Entity_Name
    {

        let context = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        do
        {
            try context.execute(deleteRequest)
            try context.save()
        }
        catch
        {
            print ("There was an error")
        }
    }
    
    func switchToFaves() {
        //var names = [String]()
        bugsKeys.removeAll()
        imgPathDict.removeAll()
        
        bugs.removeAll()
        timeDayDict.removeAll()
        monthDict.removeAll()
        print(faves.count)
        for fave in faves {
            
            let name = fave.value(forKey: "name") as! String
            bugsKeys.append(name)
            let price = fave.value(forKey: "price") as! String
            let time = fave.value(forKey: "time") as! String
            let nMonths = fave.value(forKey: "nMonths") as! String
            let sMonths = fave.value(forKey: "sMonths") as! String
            let img = fave.value(forKey: "image") as! String
            imgPathDict[name] = img
            bugs[name] = price
            timeDayDict[name] = time
            monthDict[name] = [nMonths, sMonths]
            
        }
    }
    
    
    
    func addFave(name: String, price: String, time: String, sMonths: String, nMonths:String, img:String) {
        // add a new bug or fish to core data
        let managedObject = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Favorites", in:
                  managedObject)!
        let newFave = NSManagedObject(entity: entity, insertInto: managedObject)
        newFave.setValue(name, forKeyPath: "name")
        newFave.setValue(price, forKeyPath: "price")
        newFave.setValue(time, forKeyPath: "time")
        newFave.setValue(sMonths, forKeyPath: "sMonths")
        newFave.setValue(nMonths, forKeyPath: "nMonths")
        newFave.setValue(img, forKeyPath: "image")

        do {
            try managedObject.save()
            loadFaves()

        } catch {
            let nserror = error as NSError
            NSLog("Unable to save \(nserror), \(nserror.userInfo)")
            abort()
        }
        
    }
    
    func loadFaves() {
        
        faves = [] // reset the array since we are reloading

        //1
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorites")
        
        //3
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result {
                let fave = data
                faves.append(fave)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        DispatchQueue.main.async {
            // this is the part that fixed the empty dictionary problem
            //self.specificItemTableView.reloadData()
        }
        
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
        
        
        var imgPath = imgPathDict[name]!
        var price = bugs[name]
     
        //print(price!)
        cell!.itemImage.image = UIImage(named: imgPath)
        cell!.nameLabel.text = name
        cell!.priceLabel.text = "\(String(describing: price!)) bells"
        // need to check if its a favorite and change the star icon accordingly here
        //cell!.favoriteImage.image = UIImage(named: favorite)
        if (faveExists(attr: "name", val: name)) {
            cell!.favoriteImage.image = UIImage(named: "favorite")
        }
        
        return cell!

    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let managedObject = appDelegate.persistentContainer.viewContext
        if editingStyle == .delete {
            let commit = faves[indexPath.row]
            faves.remove(at: indexPath.row)
            managedObject.delete(commit)
            
            do {
                try managedObject.save()
                tableView.deleteRows(at: [indexPath], with: .fade)
            } catch {
                let nserror = error as NSError
                NSLog("Unable to save \(nserror), \(nserror.userInfo)")
                abort()
            }
            //Reload the fruits
            self.loadFaves()

            //Reload the table view
            tableView.reloadData()
            //saveContext()
        }
    }
    
   
    func faveExists( attr: String, val: String) -> Bool {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
        let predicate = NSPredicate(format: "\(attr) == %@", val)
        request.predicate = predicate
        request.fetchLimit = 1 // only looking for 1 match

        let managedObjectContext = appDelegate.persistentContainer.viewContext

        var count = 0

        do {
            count = try managedObjectContext.count(for: request)
        }
        catch {
            print("error executing fetch request: \(error)")
        }

        return count > 0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        var dImgPath = imgPathDict[bugsKeys[indexPath.row]]!
        var dName = bugsKeys[indexPath.row]
        var dPrice = bugs[bugsKeys[indexPath.row]]!
        var dTimeDay = timeDayDict[bugsKeys[indexPath.row]]!
        var dMonths = monthDict[bugsKeys[indexPath.row]]!
//        if (goToFave) {
//            // change values
//            let item = faves[indexPath.row]
//            dName = item.value(forKey: "name") as! String
//            dPrice = item.value(forKey: "price") as! String
//            dImgPath = item.value(forKey: "image") as! String
//            dTimeDay = item.value(forKey: "time") as! String
//            dMonths = [item.value(forKey: "nMonths") as! String, item.value(forKey: "sMonths") as! String]
//
//        }
        vc?.imgPath = dImgPath
        vc?.name = dName
        vc?.price = dPrice
        vc?.timeDay = dTimeDay
        vc?.months = dMonths
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
