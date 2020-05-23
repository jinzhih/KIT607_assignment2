//
//  WonTicketTableViewCell.swift
//  KIT607_Raffle
//
//  Created by Jin Hou on 23/5/20.
//  Copyright © 2020 Jinzhi Hou. All rights reserved.
//

import UIKit

class WonTicketTableViewCell: UITableViewCell {
    @IBOutlet weak var raffleName: UILabel!
    
    @IBOutlet weak var customerName: UILabel!
    @IBOutlet weak var ticketNo: UILabel!
    @IBOutlet weak var purchaseDate: UILabel!
    @IBOutlet weak var price: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
