//
//  eBay.swift
//  FeedrReadr-PaulJurczyk
//
//  Created by Paul Jurczyk on 12/3/16.
//  Copyright © 2016 Paul Jurczyk. All rights reserved.
//

import Foundation

// MARK: Global Variables ---------------------------------------

var fetchedItems = [EbayItem]()

class EbayItem {
    var title: String
    var price: String
    var imageURL: String
    var itemURL: String
    //var description: String
    init(jsonObject: [String: Any]){
        print(jsonObject)
        let titleArray = jsonObject["title"] as? [String]
        title = (titleArray?[0])!
        let sellingStatus = jsonObject["sellingStatus"] as? [Any]
        let currentSellingStatus = sellingStatus?[0] as? [String : Any]
        let currentPrices = currentSellingStatus?["currentPrice"] as? [Any]
        let currentPrice = currentPrices?[0] as? [String : Any]
        // need to format the price to two decimal places
        let unformattedPrice = Float(currentPrice?["__value__"] as! String)
        price = String(format: "%.2f", unformattedPrice!)
        let gallery = jsonObject["galleryURL"] as! [String]
        imageURL = gallery[0]
        let itemURLs = jsonObject["viewItemURL"] as! [String]
        itemURL = itemURLs[0]
    }
   
    
    
    
    
    
    
}























