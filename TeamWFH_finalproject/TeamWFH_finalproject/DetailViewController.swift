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
    
    var name = ""
    var price = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameDetailLabel.text = name
        priceDetailLabel.text = "Price: \(price) bells"
        // Do any additional setup after loading the view.
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
