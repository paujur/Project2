//
//  DetailsViewController.swift
//  FeedrReadr-PaulJurczyk
//
//  Created by Paul Jurczyk on 1/2/17.
//  Copyright © 2017 Paul Jurczyk. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    // MARK: Local Variables -----------------
    
    var item: EbayItem?

    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var itemTitleLabel: UILabel!
    
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    override func viewDidLoad() {
        if let item = item {
            itemTitleLabel.text = item.title
            itemPriceLabel.text = item.price
        }
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
