//
//  FailPaymentViewController.swift
//  examApp
//
//  Created by APPLE on 30.12.21.
//

import UIKit

class FailPaymentViewController: UIViewController {

    @IBOutlet weak var getBackLabel: UIButton!
    @IBOutlet weak var failImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getBackLabel.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }
    


    @IBAction func getBackButton(_ sender: Any) {
    let vc = self.storyboard?.instantiateViewController(withIdentifier: "CheckOutViewController") as! CheckOutViewController
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
}
