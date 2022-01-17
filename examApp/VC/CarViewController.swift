//
//  CarViewController.swift
//  examApp
//
//  Created by APPLE on 26.12.21.
//

import UIKit
protocol CheckOutProtocol {
    func addToCart(carID: Int, action: Bool)
}
struct SelectedCar {
    var horsepower : Int!
    var model : String!
    var make: String!
    var price : Int!
    var img_url : String!
    var amount : Int!
    var id : Int!
    
}

class CarViewController: UIViewController {

    @IBOutlet weak var priceSortedDown: UIButton!
    @IBOutlet weak var priceSortedUp: UIButton!
    @IBOutlet weak var carTableView: UITableView!
    @IBOutlet weak var labelA_z: UIButton!
    @IBOutlet weak var labelZ_a: UIButton!
    
    @IBOutlet weak var finishLabel: UIButton!
    var checkOutViewDelegate : CheckOutProtocol!
    var brandsArray : [Brand]!
    var carArray :[Brand]!
    var selectedArray = [Brand]()
    var selectedCarArr = [SelectedCar]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        priceSortedDown.layer.cornerRadius = 5
        priceSortedUp.layer.cornerRadius = 5
        labelA_z.layer.cornerRadius = 5
        labelZ_a.layer.cornerRadius = 5
        priceSortedDown.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        priceSortedUp.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)

        finishLabel.layer.cornerRadius = 5
    }
    
    @IBAction func FinishButtonTapped(_ sender: Any) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "BrandsViewController") as! BrandsViewController
        self.navigationController?.popViewController(animated: true)
//        vc.brandsArray = brandsArray
        
    }
    @IBAction func priceSortedUpButton(_ sender: Any) {
        
    carArray.sort(by: { $0.price < $1.price})
    print(carArray!)
    self.carTableView.reloadData()
    
    
    }
@IBAction func priceSortedDownButton(_ sender: Any) {
    carArray.sort(by: { $0.price > $1.price})
    self.carTableView.reloadData()

    }
    @IBAction func sortedA_z(_ sender: Any) {
        carArray.sort(by: { $0.model < $1.model})
        self.carTableView.reloadData()
}
    @IBAction func sortedZ_a(_ sender: Any) {
        carArray.sort(by: { $0.model > $1.model})
        self.carTableView.reloadData()
}
    }
extension CarViewController : UITableViewDelegate,UITableViewDataSource,CarCellDelegate {
    func increaseAmount(carID: Int, action: Bool) {
        for i in 0 ..< brandsArray.count {
            if brandsArray[i].id == carID {
                var a = Brand(year: 1, id: 1, horsepower: 1, make: "", model: "", price: 1, img_url: "", amount: 1)
                if action == true {
                    print(brandsArray[i].amount)
                    a.amount = brandsArray[i].amount + 1
                }else {
                    if a.amount > 0 {
                        a.amount = brandsArray[i].amount - 1
                    }
                }
                a.year = brandsArray[i].year
                a.make = brandsArray[i].make
                a.model = brandsArray[i].model
                a.price = brandsArray[i].price
                a.horsepower = brandsArray[i].horsepower
                a.img_url = brandsArray[i].img_url
                a.id = brandsArray[i].id
                brandsArray[i] = a
                }
        }
    
        checkOutViewDelegate.addToCart(carID: carID, action: action)
//        self.carTableView.reloadData()

        
    }
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        carArray.count
    
        }
    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarCell") as? CarCell
        let currentCar = carArray[indexPath.row]
        cell?.carName.text = currentCar.make + "-" + currentCar.model
        cell?.horsePower.text = "\(currentCar.horsepower!)"
        cell?.priceLabel.text = "\(currentCar.price!)" + "$"
        cell?.carCellDelegate = self
        cell?.carID = currentCar.id
        cell?.amount = currentCar.amount

        cell?.amountLabel.text = "\(currentCar.amount)"
    
        print("cell created",indexPath.row)
        
        URLSession.shared.dataTask(with: NSURL(string: currentCar.img_url) as! URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? "No Error")
                return
            }
            
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                cell?.carImage.image = image
                print("image assigned",indexPath.row)
            })

        }).resume()
        cell?.layer.cornerRadius = 5
    
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        110
    }
    
}
extension UIImageView {
    public func imageFromURL(jsonUrlString: String, PlaceHolderImage: UIImage) {
        if self.image == nil {
            self.image = PlaceHolderImage
        }
        URLSession.shared.dataTask(with:NSURL(string: jsonUrlString)! as URL, completionHandler: { (data,response,error) -> Void  in
            if error != nil {
                print(error ?? "no error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
    }) .resume()
    }
}
