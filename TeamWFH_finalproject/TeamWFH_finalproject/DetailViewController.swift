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
        timeOfYearDetailLabel.text = "Northern"
    }
    
    @objc func southernHemisphereTapped(recognizer: UITapGestureRecognizer){
        timeOfYearDetailLabel.text = "Southern"
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
