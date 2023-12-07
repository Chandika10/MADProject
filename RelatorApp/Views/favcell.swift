//
//  favcell.swift
//  RelatorApp
//
//  Created by Pavan Pullugundla on 12/7/23.
//

import UIKit

class favcell: UITableViewCell {

    
    @IBOutlet weak var favhoteltitles: UILabel!
    
    
    @IBOutlet weak var favhoteltype: UILabel!
    
    
    @IBOutlet weak var favhotelrating: UILabel!
    
    @IBOutlet weak var favhoteladdress: UILabel!
    
    @IBOutlet weak var favhotelprice: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
