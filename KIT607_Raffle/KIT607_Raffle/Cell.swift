//
//  Cell.swift
//  KIT607_Raffle
//
//  Created by Jin Hou on 7/5/20.
//  Copyright © 2020 Jinzhi Hou. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {

    @IBOutlet weak var raffleName: UILabel!
    
    @IBOutlet weak var raffleDrawDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       print("1")
    
      
    }
    
}
