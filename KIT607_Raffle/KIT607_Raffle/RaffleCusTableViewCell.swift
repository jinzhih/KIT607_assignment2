//
//  RaffleCusTableViewCell.swift
//  KIT607_Raffle
//
//  Created by Jin Hou on 7/5/20.
//  Copyright © 2020 Jinzhi Hou. All rights reserved.
//

import UIKit

class RaffleCusTableViewCell: UITableViewCell {
    
    @IBOutlet weak var raffleName: UILabel!
    @IBOutlet weak var raffleDrawDate: UILabel!
    
    @IBOutlet weak var raffleImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
