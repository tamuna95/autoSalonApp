//
//  ViewController.swift
//  examApp
//
//  Created by APPLE on 22.12.21.
//

import UIKit



class ViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.clearButtonMode = .always
        passwordTextField.clearButtonMode = .whileEditing
        emailTextfield.clearButtonMode = .always
        emailTextfield.clearButtonMode = .whileEditing
    }

    @IBAction func logInButton(_ sender: Any) {
        if passwordTextField.text == "Iloveswift" && emailTextfield.text != " " {
            let vc = storyboard?.instantiateViewController(withIdentifier: "BrandsViewController") as! BrandsViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else {
            
            showAlert()
        }
        
    }
    func showAlert() {
        let alert = UIAlertController(title: "მეილი ან პაროლი არასწორია", message: "სცადეთ თავიდან", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
                case .default:
                print("default")
                
                case .cancel:
                print("cancel")
                
                case .destructive:
                print("destructive")
                
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
    

