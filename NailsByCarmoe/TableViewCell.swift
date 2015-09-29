//
//  TableViewCell.swift
//  NailsByCarmoe
//
//  Created by Simon Carlsson on 24/09/15.
//  Copyright © 2015 Simon Carlsson. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var TextViewOutlet: UITextView!
    
    /*override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    } */
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    /// Custom setter so we can initialise the height of the text view
    var textString: String {
        get {
            return TextViewOutlet.text
        }
        set {
            TextViewOutlet.text = newValue
            
            textViewDidChange(TextViewOutlet)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Disable scrolling inside the text view so we enlarge to fitted size
        TextViewOutlet.scrollEnabled = false
        TextViewOutlet.delegate = self
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            TextViewOutlet.becomeFirstResponder()
        } else {
            TextViewOutlet.resignFirstResponder()
        }
    }
}

extension TableViewCell: UITextViewDelegate {
    func textViewDidChange(textView: UITextView!) {
        
        let size = textView.bounds.size
        let newSize = textView.sizeThatFits(CGSize(width: size.width, height: CGFloat.max))
        
        // Resize the cell only when cell's size is changed
        if size.height != newSize.height {
            UIView.setAnimationsEnabled(false)
            tableView?.beginUpdates()
            tableView?.endUpdates()
            UIView.setAnimationsEnabled(true)
            
            if let thisIndexPath = tableView?.indexPathForCell(self) {
                tableView?.scrollToRowAtIndexPath(thisIndexPath, atScrollPosition: .Bottom, animated: false)
            }
        }
    }
}
