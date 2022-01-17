//
//  SuccessfulPaymentViewController.swift
//  examApp
//
//  Created by APPLE on 30.12.21.
//

import UIKit

protocol getBackProtocol {
    func getBackFunction()
}

class SuccessfulPaymentViewController: UIViewController {

    @IBOutlet weak var getBackLabel: UIButton!
    @IBOutlet weak var successImage: UIImageView!
    var getBack : getBackProtocol!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getBackLabel.layer.cornerRadius = 5 
    }
    
    @IBAction func getBackButton(_ sender: Any) {
        getBack.getBackFunction()

        self.dismiss(animated: true, completion: nil)
        
}
}
