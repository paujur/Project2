//
//  MyTableViewCell.swift
//  FeedrReadr-PaulJurczyk
//
//  Created by Paul Jurczyk on 12/30/16.
//  Copyright © 2016 Paul Jurczyk. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        UIView.animate(withDuration: 12.0, delay: 1, options: ([.curveLinear, .repeat]), animations: {() -> Void in
            self.itemTitleLabel.center = CGPoint(x: 0 - self.itemTitleLabel.bounds.size.width / 2, y: self.itemTitleLabel.center.y)
        }, completion:  { _ in })
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
