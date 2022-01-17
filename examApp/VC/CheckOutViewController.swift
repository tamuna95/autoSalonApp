//
//  CheckOutViewController.swift
//  examApp
//
//  Created by APPLE on 28.12.21.
//

import UIKit
protocol clearData {
    func data ()
}
class CheckOutViewController: UIViewController {
    
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var comissionLabel: UILabel!
    @IBOutlet weak var serviceLabel: UILabel!
    
    @IBOutlet weak var payLabel: UIButton!
    var brandsArray : [Brand]!
    var carSet = Set<String>()
    var sumOfPrice : Int = 0
    
    var clearDataDelegate : clearData!
    
    @IBOutlet weak var checkOutTableView: UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        payLabel.layer.cornerRadius = 5
         brandsArray = brandsArray.filter { $0.amount > 0 }
        for i in brandsArray {
            carSet.insert(i.make)
            sumOfPrice = sumOfPrice + (i.amount * i.price)
            
        }
        totalPrice.text = "\(sumOfPrice)" + "$"
        serviceLabel.text = "\(sumOfPrice / 100)" + "$"
        
        checkOutTableView.register(MyCustomHeader.self,
               forHeaderFooterViewReuseIdentifier: "sectionHeader")
    }
    
    @IBAction func paymentButtonDidTap(_ sender: Any) {
        if sumOfPrice > 200000 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "SuccessfulPaymentViewController") as! SuccessfulPaymentViewController
            vc.getBack = self
            self.present(vc, animated: true, completion: nil)
        }else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "FailPaymentViewController") as! FailPaymentViewController
            self.present(vc, animated: true, completion: nil)
        }
        
    }
}


extension CheckOutViewController :UITableViewDelegate,UITableViewDataSource,getBackProtocol {
    
    func getBackFunction() {
        clearDataDelegate.data()
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var car : Int = 0
        for i in 0..<brandsArray.count {
                if brandsArray[i].make == Array(carSet)[section] {
                    car += 1
                }
        }
        return car
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckOutCell", for: indexPath) as! CheckOutCell
        let b = brandsArray.filter { $0.make == Array(carSet)[indexPath.section]}
        let currentCar = b[indexPath.row]

                    cell.priceLabel.text = "\(currentCar.price!)" + "$"
        cell.carName.text = "\(currentCar.make!)" + "\(currentCar.model!)"
                    cell.horsePower.text = "\(currentCar.horsepower!)"
                    cell.carAmount.text = "\(currentCar.amount)" + "x"
                    cell.totalPriceLabel.text = "სულ" + " " + "\(currentCar.price * currentCar.amount)" + "$"
        
        URLSession.shared.dataTask(with: NSURL(string: currentCar.img_url) as! URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? "No Error")
                return
            }
            
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                cell.carImageview.image = image
                print("image assigned",indexPath.row)
            })

        }).resume()

        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        carSet.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection
                                section: Int) -> UIView? {
        var str = " "
        for i in 0..<carSet.count {
            if i == section {
                str = Array(carSet)[i]
            }
        }
        
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                       "sectionHeader") as! MyCustomHeader
        view.title.text = str
        view.image.image = UIImage.init(named:"myCarImage")
        switch str {
        case "bmw" :
            view.image.image = UIImage.init(named:"bmw_icon") ?? UIImage.init(named: "myCarImage")
        case "dodge" :
            view.image.image = UIImage.init(named:"dodge_icon") ?? UIImage.init(named: "myCarImage")
        case "mercedes" :
            view.image.image = UIImage.init(named:"mercedes_icon") ?? UIImage.init(named: "myCarImage")
        case "mitsubishi":
            view.image.image = UIImage.init(named:"mitsubishi_icon") ?? UIImage.init(named: "myCarImage")
        case "opel":
            view.image.image = UIImage.init(named: "opel_icon") ?? UIImage.init(named: "myCarImage")
        default:
            view.image.image = UIImage.init(named:"myCarImage")

        }
//      if str == "bmw" {
//            view.image.image = UIImage.init(named:"bmw_icon") ?? UIImage.init(named: "myCarImage")
//}
           return view
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}

