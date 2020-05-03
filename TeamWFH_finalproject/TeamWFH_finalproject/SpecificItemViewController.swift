//
//  SpecificItemViewController.swift
//  TeamWFH_finalproject
//
//  Created by Alison Wilkes on 5/3/20.
//  Copyright © 2020 Alison Wilkes. All rights reserved.
//

import UIKit

class SpecificItemViewController: UIViewController {
    

    @IBOutlet weak var typeNavLabel: UINavigationItem!
    @IBOutlet weak var specificItemTableView: UITableView!
    
    var type = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = type
        // Do any additional setup after loading the view.
    }
    

}

extension SpecificItemViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = specificItemTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SpecificItemTableViewCell
        return cell!
        
    }
    
    
}
