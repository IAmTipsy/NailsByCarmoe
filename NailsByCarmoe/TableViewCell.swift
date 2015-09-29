//
//  TableViewCell.swift
//  NailsByCarmoe
//
//  Created by Simon Carlsson on 24/09/15.
//  Copyright © 2015 Simon Carlsson. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var TextViewOutlet: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

