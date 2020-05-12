//
//  DataSession.swift
//  TeamWFH_finalproject
//
//  Created by Jill Rosow on 5/3/20.
//  Copyright © 2020 Alison Wilkes. All rights reserved.
//

import UIKit

protocol DataProtocol
{
    func responseDataHandler(data:String)
    func responseError(message:String)
    func typeTransfer(data:String)
    
}

class DataSession {
    private let urlSession = URLSession.shared

    //default path just in case
    var urlPathBase = "https://nookipedia.com/w/api.php?action=parse&page=Bugs/New_Horizons&prop=wikitext&format=json&formatversion=2"
    var typeDelegate: DataProtocol?
    var itemType: String = ""
    
    func retrieving() -> String{//getting item type
        typeDelegate?.typeTransfer(data: itemType)
        print(itemType)
        if itemType == "Bug"{
            urlPathBase = "https://nookipedia.com/w/api.php?action=parse&page=Bugs/New_Horizons&prop=wikitext&format=json&formatversion=2"
        }
        else if itemType == "Fish"{
            urlPathBase = "https://nookipedia.com/w/api.php?action=parse&page=Fish/New_Horizons&prop=wikitext&format=json&formatversion=2"
        }
        return(urlPathBase)
    }
    private var dataTask:URLSessionDataTask? = nil
    
    var delegate:DataProtocol? = nil
    
    init() {}
    
    func getData(itemURLType: String) {//this needs to take an input or else it doesn't work with urlPathBase
        let urlPath = itemURLType
        
        //urlPath = urlPath + exampleDataNumber
        
        let url:NSURL? = NSURL(string: urlPath)
        
        let dataTask = self.urlSession.dataTask(with: url! as URL) { (data, response, error) -> Void in
            if error != nil {
                print(error!)
            } else {
                do {
                    let jsonResult = try JSONSerialization.jsonObject(with: data!, options: [JSONSerialization.ReadingOptions.mutableContainers]) as? NSDictionary
                    if jsonResult != nil {
                        //print(jsonResult)
                        if let parse = jsonResult!["parse"] as? [String: Any] {
                            //print("parse:", parse)
                            if let wikitext = parse["wikitext"] {
                                //print("wikitext:",wikitext) // this is the content
                                //print(type(of: wikitext))
                                self.delegate?.responseDataHandler(data: wikitext as! String)
                            } else {
                                self.delegate?.responseError(message: "Fake data not found")
                            }
                        }
                        
//                        let title: String? = jsonResult!["title"] as? String
//                        let body: String? = jsonResult!["body"] as? String
                         
                    }
                } catch {
                    //Catch and handle the exception
                }
            }
        }
        dataTask.resume()
    }
    
}

