//
//  CarCell.swift
//  examApp
//
//  Created by APPLE on 26.12.21.
//

import UIKit


protocol CarCellDelegate {
    func increaseAmount(carID: Int, action: Bool)
        
}

class CarCell: UITableViewCell {

    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var horsePower: UILabel!
    @IBOutlet weak var carName: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    
    var carCellDelegate : CarCellDelegate!
    var carID :Int!
    var amount = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        amountLabel.text = "\(amount)"

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func decreaseAmount(_ sender: UIButton) {
        carCellDelegate.increaseAmount(carID: carID, action: false)
        
        if amount > 0 {
            amount -= 1
            amountLabel.text = "\(amount)"
        }
    }
    
    @IBAction func increaseAmount(_ sender: UIButton) {
        carCellDelegate.increaseAmount(carID: carID, action: true)
        amount += 1
        amountLabel.text = "\(amount)"
       
    }
    
    
}
