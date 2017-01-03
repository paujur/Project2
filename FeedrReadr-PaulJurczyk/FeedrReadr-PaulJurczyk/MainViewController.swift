//
//  ViewController.swift
//  FeedrReadr-PaulJurczyk
//
//  Created by Paul Jurczyk on 12/2/16.
//  Copyright © 2016 Paul Jurczyk. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK Local Variables ---------------------------
    
    var searchQuery = ""
    var searchInitiated = Bool()
    var imageEndpoint = ""
    // May want to me the vars below to somewhere more global, or into a class
    var newEndPoint = "http://svcs.ebay.com/services/search/FindingService/v1?"
    var operationName = "OPERATION-NAME=findItemsByKeywords"
    var version = "&SERVICE-VERSION=1.13.0"
    var appName = "&SECURITY-APPNAME=PaulJurc-FeedrRea-PRD-445f0c763-0cddb7b8"
    var globalId = "&GLOBAL-ID=EBAY-US"
    var pagination = "&paginationInput.entriesPerPage=20"
    var responseEncoding = "&X-EBAY-API-RESPONSE-ENCODING=JSON"
    var restPayload = "&REST-PAYLOAD"
    var callback = "fetchData" // I believe this needs to be the same as teh function that's calling the API call
    var dataFormat = "&RESPONSE-DATA-FORMAT=JSON"
    //var fetchedResult = [String : Any]()
    
    
    // MARK: IBOutlets ---------------------------------------------
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var mainTableView: UITableView!
    
    // MARK: IBActions ------------------------------
    
    @IBAction func searchButtonTapped(_ sender: UIButton) {
        fetchedItems = [EbayItem]()
        self.newEndPoint = "http://svcs.ebay.com/services/search/FindingService/v1?"
        searchQuery = searchTextField.text!
        let keyword = "&keywords=" + searchQuery
        let encodedURL = newEndPoint + operationName + version + appName + globalId + keyword + pagination + dataFormat + restPayload + callback
        newEndPoint = encodedURL
        //print(newEndPoint)
        fetchData() { result in
            
            do {
                
                
                let jsonObject = try JSONSerialization.jsonObject(with: result, options: .mutableContainers) as! [String : Any]
                
                
                
                let resultsTopLayer = jsonObject["findItemsByKeywordsResponse"] as? [Any]
                let oneMoreLayer = resultsTopLayer?[0] as? [String : Any]
                let results = oneMoreLayer?["searchResult"] as? [Any]
                let actualResults = results?[0] as? [String : Any]
                let items = actualResults?["item"] as? [Any]
                for item in items! {
                    let newItem = EbayItem(jsonObject: item as! [String : Any])
                    fetchedItems.append(newItem)
                }
                
                //let itemTitle =
                //                let titleArray = item?["title"] as? [String]
                //                let title = titleArray?[0]
                //                let categoryArray = item?["categoryName"] as? [String]
                //                let category = categoryArray?[0]
                //                let galleryURLArray = item?["galleryURL"] as? [String]
                //                let galleryURL = galleryURLArray?[0]
                //                let itemURLArray = item?["viewItemURL"] as? [String]
                //                let itemURL = itemURLArray?[0]
                //                let priceInfo = item?["currentPrice"] as? [String : Any]
                //                let price = priceInfo?["__value__"] as? String
                //                let conditionInfo = item?["condition"] as? [String : Any]
                //                let condition = conditionInfo?["conditionDisplayName"] as? String
            }
            catch {
                print("we gots an error")
            }
        }
        
    }
    
    
    func fetchData(closure: @escaping (Data) -> ()) {
        
        let endpoint = newEndPoint
        let url = URLRequest(url: URL(string: endpoint)!)
        // need to make this a POST in order to receive JSON, not GET
        //url.httpMethod = "GET"
        // this tries to add the right parameter to the header
        //url.setValue("JSON", forHTTPHeaderField: "X-EBAY-SOA-RESPONSE-DATA-FORMAT")
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: url) { (data, response, error) in
            // TODO: add error handling
            
            guard let responseData = data else {
                // self.itemTextView.text = "Error: did not receive data"
                return
            }
            DispatchQueue.main.async {
                closure(responseData)
                self.mainTableView.reloadData()                }
        }
        
        
        task.resume()
        
    }
    
    func fetchImages(closure: @escaping (Data) ->()) {
        let endpoint = imageEndpoint
        let url = URLRequest(url: URL(string: endpoint)!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let imageResponseData = data else {
                print("Error: couldn't load image.")
                return
            }
            DispatchQueue.main.async {
                closure(imageResponseData)
            }
        }
        task.resume()
    }
    
    // MARK: Tableview Protocols
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! MyTableViewCell
        cell.itemTitleLabel.text = fetchedItems[indexPath.row].title
        cell.itemPriceLabel.text = "$ " + fetchedItems[indexPath.row].price
        let imageURL = fetchedItems[indexPath.row].imageURL
        imageEndpoint = imageURL
        self.fetchImages { result in
            cell.itemImageView.image = UIImage(data: result)
        }
        return cell
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

