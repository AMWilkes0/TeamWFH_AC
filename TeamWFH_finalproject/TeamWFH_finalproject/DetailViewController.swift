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
    @IBOutlet weak var isFavoriteImage: UIImageView!
    
    var name = ""
    var price = ""
    var imgPath = ""
    var timeDay = ""
    var months = Array<String>()
    var isFavorite = true

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
        timeOfYearDetailLabel.text = "None"
        timeOfYearDetailLabel.alpha = 0.0
        if(!isFavorite){
            isFavoriteImage.alpha = 0.0
        }
        // Do any additional setup after loading the view.
        }

        @objc func northernHemisphereTapped(recognizer: UITapGestureRecognizer){
            UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut, .autoreverse], animations: {
                    self.northernHemisphereDetail.alpha = 0.5
                }, completion: { finished in self.northernHemisphereDetail.alpha = 1.0
                    })
            
            timeOfYearDetailLabel.text = "Active Northern hemisphere months:\n\(months[0])"
            
            if (timeOfYearDetailLabel.alpha == 1.0){
                UIView.animate(withDuration: 0.1, animations: {
                    self.timeOfYearDetailLabel.alpha = 0.0})
                timeOfYearDetailLabel.text = "Active Southern hemisphere months:\n\(months[1])"
            }
            UIView.animate(withDuration: 0.3, animations: {
            self.timeOfYearDetailLabel.alpha = 1.0})
            
            timeOfYearDetailLabel.sizeToFit()

        }

        @objc func southernHemisphereTapped(recognizer: UITapGestureRecognizer){
            UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseInOut, .autoreverse], animations: {
                self.southernHemisphereDetail.alpha = 0.5
            }, completion: { finished in self.southernHemisphereDetail.alpha = 1.0
                })
            
            timeOfYearDetailLabel.text = "Active Southern hemisphere months:\n\(months[1])"
            
            if (timeOfYearDetailLabel.alpha == 1.0){
                UIView.animate(withDuration: 0.1, animations: {
                    self.timeOfYearDetailLabel.alpha = 0.0})
                timeOfYearDetailLabel.text = "Active Southern hemisphere months:\n\(months[1])"
            }
            UIView.animate(withDuration: 0.3, animations: {
            self.timeOfYearDetailLabel.alpha = 1.0})
        }

    
    @IBAction func faveButton(_ sender: Any) {
        if(isFavorite){
            isFavorite = false
            isFavoriteImage.alpha = 0.0
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "SpecificItemViewController") as? SpecificItemViewController
            print("name:", name, "price:", price)
            // Create the alert controller
            let alertController = UIAlertController(title: "Alert", message: "Favorite removed.", preferredStyle: .alert)

            // Create the actions
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                UIAlertAction in
                NSLog("OK Pressed")
            }

            // Add the action
            alertController.addAction(okAction)

            // Present the controller
            self.present(alertController, animated: true, completion: nil)
            vc?.removeFave(name: name, price: price, time: timeDay, sMonths: months[1], nMonths: months[0], img:imgPath)
            
        } else{
            isFavorite = true
            isFavoriteImage.alpha = 1.0
            
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
