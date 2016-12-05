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
    var operationName = "&OPERATION-NAME=findItemsByKeywords"
    var version = "&SERVICE-VERSION=1.13.0"
    var appName = "&SECURITY-APPNAME=PaulJurc-FeedrRea-PRD-445f0c763-0cddb7b8"
    var globalId = "&GLOBAL-ID=EBAY-US"
    var pagination = "&paginationInput.entriesPerPage=5"
    var responseEncoding = "&X-EBAY-API-RESPONSE-ENCODING=JSON"
    var restPayload = "&REST-PAYLOAD"
    var callback = "&callback=_cb_findItemsByKeywords"
    var result = [String : Any]()
    
    
    // MARK: IBOutlets ---------------------------------------------
    
    @IBOutlet weak var searchTextField: UITextField!
    
    // MARK: IBActions ------------------------------
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        let keyword = "kewyord=" + searchQuery + "&" // may need to inser '+' where there are spaces in the searchQuery
        searchQuery = searchTextField.text!
        let encodedURL = newEndPoint + operationName + version + appName + globalId + restPayload + callback + keyword + pagination
        newEndPoint = encodedURL
        print(newEndPoint)
        fetchData() { result in
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: result, options: .mutableContainers) as! [String : Any]
                let resultsTopLayer = jsonObject["findItemsByKeywordsResponse"] as? [String : Any]
                let results = resultsTopLayer?["searchResult"] as? [String : Any]
                let item = results?["item"] as? [String : Any]
                let titleArray = item?["title"] as? [String]
                let title = titleArray?[0]
                let categoryArray = item?["categoryName"] as? [String]
                let category = categoryArray?[0]
                let galleryURLArray = item?["galleryURL"] as? [String]
                let galleryURL = galleryURLArray?[0]
                let itemURLArray = item?["viewItemURL"] as? [String]
                let itemURL = itemURLArray?[0]
                let priceInfo = item?["currentPrice"] as? [String : Any]
                let price = priceInfo?["__value__"] as? String
                let conditionInfo = item?["condition"] as? [String : Any]
                let condition = conditionInfo?["conditionDisplayName"] as? String
            }
            catch {
                
            }
        }
        
    }
    
    
    private func fetchData(closure: @escaping (Data) -> ()) {
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
                    closure(responseData)
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

