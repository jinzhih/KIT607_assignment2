//
//  RaffleUITableViewCell.swift
//  KIT607_Raffle
//
//  Created by Jin Hou on 26/4/20.
//  Copyright © 2020 Jinzhi Hou. All rights reserved.
//

import UIKit

class RaffleUITableViewCell: UITableViewCell {
    @IBOutlet var nameRaffle: UILabel!
    
    @IBOutlet weak var raffleImage: UIImageView!
    @IBOutlet var desRaffle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
