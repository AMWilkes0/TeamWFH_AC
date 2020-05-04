//
//  BasicItemTableViewController.swift
//  TeamWFH_finalproject
//
//  Created by Alison Wilkes on 5/3/20.
//  Copyright © 2020 Alison Wilkes. All rights reserved.
//

import UIKit


class BasicItemTableViewController: UITableViewController {
    
    var items = [Items]()
    var thumbnails = [UIImage]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let itemCellIdentifier = "itemTableViewCell"

        let cell = tableView.dequeueReusableCell(withIdentifier: itemCellIdentifier, for: indexPath) as? BasicItemTableViewCell
        
        cell!.picItemImageView.image = thumbnails[indexPath.row]
        cell!.nameItemLabel.text = items[indexPath.row].name
         
         return cell!
    }
    
   
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    
    private func loadItems() {
        
        //I did this the 'dumb' way because storing this data in CoreData seemed useless when nothing will be added to the table view
        let thumbnail1 = UIImage(named:"bug")
        let thumbnail2 = UIImage(named:"fossil")
        let thumbnail3 = UIImage(named:"fish")
        let thumbnail4 = UIImage(named: "favorite")
       
        thumbnails += [thumbnail1!, thumbnail2!, thumbnail3!, thumbnail4!]
       
        let bug = Items(name: "Bug", portrait: "bug")
        let fossil = Items(name: "Fossil", portrait: "fossil")
        let fish = Items(name: "Fish", portrait: "fish")
        let favorite = Items(name: "Favorites", portrait: "favorite")
       
        items += [bug, fossil, fish, favorite]
        
    }
    
    //send to SpecificItemTableViewCell what basic item you selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SpecificItemViewController") as? SpecificItemViewController
        vc?.type = items[indexPath.row].name
        
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
