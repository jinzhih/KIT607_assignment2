//
//  WinnersTableViewCell.swift
//  KIT607_Raffle
//
//  Created by Jin Hou on 24/5/20.
//  Copyright © 2020 Jinzhi Hou. All rights reserved.
//

import UIKit

class WinnersTableViewCell: UITableViewCell {

    @IBOutlet weak var ticketNO: UILabel!
    @IBOutlet weak var winner: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
