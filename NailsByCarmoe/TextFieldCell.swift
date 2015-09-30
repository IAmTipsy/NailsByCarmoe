//
//  TextFieldCell.swift
//  NailsByCarmoe
//
//  Created by Simon Carlsson on 29/09/15.
//  Copyright © 2015 Simon Carlsson. All rights reserved.
//

import UIKit

class TextFieldCell: UITableViewCell {

    @IBAction func textAction(sender: AnyObject) {
        textFieldDidChange(TextFieldOut)
        print("knap")
        
    }
    @IBOutlet weak var TextFieldOut: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            TextFieldOut?.becomeFirstResponder()
        } else {
            TextFieldOut?.resignFirstResponder()
        }
    }
    

}
extension TextFieldCell: UITextFieldDelegate {
    func textFieldDidChange(textView: UITextField) {
        
        print("Test")
            
        if var thisIndexPath = tableView?.indexPathForCell(self) {
            thisIndexPath = NSIndexPath(forRow: thisIndexPath.row-1, inSection: thisIndexPath.section)
            tableView?.reloadRowsAtIndexPaths([thisIndexPath], withRowAnimation: UITableViewRowAnimation.Top)
            print("Updating cell")
        }
    }
}
