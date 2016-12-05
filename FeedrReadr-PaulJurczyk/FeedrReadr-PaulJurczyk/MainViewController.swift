//
//  ViewController.swift
//  FeedrReadr-PaulJurczyk
//
//  Created by Paul Jurczyk on 12/2/16.
//  Copyright © 2016 Paul Jurczyk. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK Local Variables ---------------------------
    
    var searchQuery = ""
    var searchInitiated = Bool()
    // May want to me the vars below to somewhere more global, or into a class
    var newEndPoint = "http://svcs/ebay.com/services/search/FindingService/v1?"
    var operationName = "OPERATION-NAME=findItemsByKeywords&"
    var version = "SERVICE-VERSION=1.13.0&"
    var appName = "SECURITY-APPNAME=PaulJurc-FeedrRea-PRD-445f0c763-0cddb7b8&"
    var globalId = "GLOBAL-ID=EBAY-US&"
    var pagination = "paginationInput.entriesPerPage=5"
    
    
    
    // MARK: IBOutlets ---------------------------------------------
    
    @IBOutlet weak var searchTextField: UITextField!
    
    // MARK: IBActions ------------------------------
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        let keyword = "kewyord=" + searchQuery + "&" // may need to inser '+' where there are spaces in the searchQuery
        searchQuery = searchTextField.text!
        let encodedURL = newEndPoint + operationName + version + appName + globalId + keyword + pagination
        newEndPoint = encodedURL
        
        fetchData() { result in
            //something = result
        }
        
    }
    
    
    private func fetchData(closure: @escaping (String) -> ()) {
        if searchInitiated == true {
            let endpoint = newEndPoint
            let url = URLRequest(url: URL(string: endpoint)!)
            let session = URLSession(configuration: URLSessionConfiguration.default)
            let task = session.dataTask(with: url) { (data, response, error) in
                // TODO: add error handling
                guard let responseData = data else {
                   // self.itemTextView.text = "Error: did not receive data"
                    return
                }
                DispatchQueue.main.async {
                    closure(String(data: responseData, encoding: String.Encoding.utf8)!)
                }
            }
            task.resume()
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

