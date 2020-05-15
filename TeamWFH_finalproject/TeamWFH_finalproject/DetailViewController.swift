//
//  DetailViewController.swift
//  TeamWFH_finalproject
//
//  Created by Alison Wilkes on 5/11/20.
//  Copyright © 2020 Alison Wilkes. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageDetail: UIImageView!
    @IBOutlet weak var nameDetailLabel: UILabel!
    @IBOutlet weak var priceDetailLabel: UILabel!
    @IBOutlet weak var timeOfDayDetailLabel: UILabel!
    @IBOutlet weak var northernHemisphereDetail: UIImageView!
    @IBOutlet weak var southernHemisphereDetail: UIImageView!
    @IBOutlet weak var timeOfYearDetailLabel: UILabel!
    
    var name = ""
    var price = ""
    var imgPath = ""
    var timeDay = ""
    var months = Array<String>()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let wasNorthern = UITapGestureRecognizer(target: self, action: #selector(northernHemisphereTapped))
        northernHemisphereDetail.addGestureRecognizer(wasNorthern)
        let wasSouthern = UITapGestureRecognizer(target: self, action: #selector(southernHemisphereTapped))
        southernHemisphereDetail.addGestureRecognizer(wasSouthern)
        
        imageDetail.image = UIImage(named: imgPath)
        nameDetailLabel.text = name
        priceDetailLabel.text = "Price: \(price) bells"
        timeOfDayDetailLabel.text = "Active time of day: \(timeDay)"
        // Do any additional setup after loading the view.
    }
    
    @objc func northernHemisphereTapped(recognizer: UITapGestureRecognizer){
        timeOfYearDetailLabel.text = "Active Northern hemisphere months:\n\(months[0])"
        timeOfYearDetailLabel.sizeToFit()

    }
    
    @objc func southernHemisphereTapped(recognizer: UITapGestureRecognizer){
        timeOfYearDetailLabel.text = "Active Southern hemisphere months:\n\(months[1])"
    }
    @IBAction func faveButton(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SpecificItemViewController") as? SpecificItemViewController
        print("name:", name, "price:", price)
        // Create the alert controller
        let alertController = UIAlertController(title: "Alert", message: "Favorite saved!", preferredStyle: .alert)

        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("OK Pressed")
        }

        // Add the action
        alertController.addAction(okAction)

        // Present the controller
        self.present(alertController, animated: true, completion: nil)
        vc?.addFave(name: name, price: price, time: timeDay, sMonths: months[1], nMonths: months[0], img:imgPath)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
