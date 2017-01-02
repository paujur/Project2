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
    var name: String
    var price: String
    //var description: String
    init(jsonObject: [String: Any]){
        let resultsTopLayer = jsonObject["findItemsByKeywordsResponse"] as? [String : Any]
        let results = resultsTopLayer?["searchResult"] as? [String : Any]
        let item = results?["item"] as? [String : Any]
        let titleArray = item?["title"] as? [String]
        name = (titleArray?[0])!
        let categoryArray = item?["categoryName"] as? [String]
        let category = categoryArray?[0]
        let galleryURLArray = item?["galleryURL"] as? [String]
        let galleryURL = galleryURLArray?[0]
        let itemURLArray = item?["viewItemURL"] as? [String]
        let itemURL = itemURLArray?[0]
        let priceInfo = item?["currentPrice"] as? [String : Any]
        price = (priceInfo?["__value__"] as? String)!
        let conditionInfo = item?["condition"] as? [String : Any]
        let condition = conditionInfo?["conditionDisplayName"] as? String
    }
   
    
    
    
    
    
    
}
