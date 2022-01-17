//
//  CheckOutCell.swift
//  examApp
//
//  Created by APPLE on 28.12.21.
//

import UIKit

class CheckOutCell: UITableViewCell {

    @IBOutlet weak var carName: UILabel!
    @IBOutlet weak var carAmount: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var horsePower: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var carImageview: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
