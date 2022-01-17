//
//  BrandCell.swift
//  examApp
//
//  Created by APPLE on 23.12.21.
//

import UIKit

class BrandCell: UITableViewCell {

    @IBOutlet weak var brandNameLabel: UILabel!
    @IBOutlet weak var brandImage: UIImageView!
     
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func tapBrandButton(_ sender: Any) {
    }
}
