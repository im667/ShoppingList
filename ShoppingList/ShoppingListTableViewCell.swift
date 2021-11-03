//
//  ShoppingListTableViewCell.swift
//  SeSAC_03_Mylog
//
//  Created by mac on 2021/10/13.
//

import UIKit

class ShoppingListTableViewCell: UITableViewCell {

    @IBOutlet weak var dataLabel: UILabel!
    
    @IBOutlet weak var checkboxBtn: UIButton!
    
    @IBOutlet weak var bookmarkBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
