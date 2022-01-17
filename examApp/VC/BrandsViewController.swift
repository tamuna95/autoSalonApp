//
//  BrandsViewController.swift
//  examApp
//
//  Created by APPLE on 23.12.21.
//

import UIKit

class BrandsViewController: UIViewController {
    

    @IBOutlet weak var brandsTableView: UITableView!
    @IBOutlet weak var checkoutView: UIView!
    
    @IBOutlet weak var parentView: UIView!
    
    @IBOutlet weak var goCheckOutPage: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    @IBOutlet weak var generalView: UIView!
    
    var brandsArray = [Brand]()
    var oldBrandsArray = [OldBrand]()
    var brandsName = Set<String>()
    var brandsNameArray = [String]()
    var copyCarArray = [SelectedCar]()
    var carTotalAmount : Int = 0
    var carTotalPrice : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromWeb()

        checkoutView.isHidden = true
}
    
    func getDataFromWeb(){
        let jsonUrlString = "https://private-anon-a41c950c16-carsapi1.apiary-mock.com/cars?fbclid=IwAR0wRAgw30gahMQTh1CZxZQf2lwSpp2VJRwsvDRDaxf_HGhMydrovMhgZV4"
        let url = URL(string: jsonUrlString)!
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if data != nil {
                print(data)
                let result = try? JSONDecoder().decode([OldBrand].self, from: data!)
                if  result != nil{
                    self.oldBrandsArray = result!
                    for i in self.oldBrandsArray {
                        var brand = Brand(year: 0, id: 0, horsepower: 0, make: "", model: "", price: 0, img_url: "", amount: 0)
                        brand.amount = 0
                        brand.model = i.model
                        brand.price = i.price
                        brand.img_url = i.img_url
                        brand.make = i.make
                        brand.year = i.year
                        brand.horsepower = i.horsepower
                        brand.id = i.id
                        self.brandsArray.append(brand)
                    }
                    for i in self.oldBrandsArray {
                        self.brandsName.insert(i.make)
                    }
//
                    DispatchQueue.main.async {
                        self.brandsTableView.reloadData()
                    }
                }
            }
        }.resume()
    }
    
    
    @IBAction func AddToCardButton(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CheckOutViewController") as! CheckOutViewController
        vc.clearDataDelegate = self
        self.navigationController?.pushViewController(vc, animated: true)
        vc.brandsArray = brandsArray
        
    }
    func clearData(){
        print("YESS!!")
        for i in 0..<brandsArray.count {
            brandsArray[i].amount = 0
        
        }
        
    }
}

extension BrandsViewController : UITableViewDelegate,UITableViewDataSource, CheckOutProtocol,clearData {
  func data() {
      checkoutView.isHidden = true

      for i in 0..<brandsArray.count {
          brandsArray[i].amount = 0
      
      }
      
    }
  
    
    func addToCart(carID: Int, action: Bool){
        print(carID)
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
//        self.brandsTableView.reloadData()
        carTotalAmount = 0
        carTotalPrice = 0
        for item in brandsArray {
            if item.amount > 0 {
                checkoutView.isHidden = false
            }
            carTotalAmount += item.amount
            carTotalPrice += item.price * item.amount
        }
        priceLabel.text = "\(carTotalPrice)" + "$"
        countLabel.text = "\(carTotalAmount)" + "x"
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        brandsName.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BrandCell", for: indexPath) as! BrandCell
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 0.5
        for i in brandsName.indices {
            var item = self.brandsName[i]
            brandsNameArray.append(item)
        print(brandsNameArray)
        }
        let currentBrand = brandsNameArray[indexPath.row]
        cell.brandNameLabel.text = currentBrand
        cell.brandImage.image = UIImage.init(named: currentBrand + "_icon") ?? UIImage.init(named: "myCarImage")

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CarViewController") as! CarViewController
        vc.checkOutViewDelegate = self
        vc.brandsArray = brandsArray
        var selectedCars = [Brand]()
        
        if let selected = tableView.indexPathForSelectedRow {
            let car = tableView.cellForRow(at: selected) as! BrandCell
            print(selected.row)
            var name = car.brandNameLabel.text

            for i in brandsArray {
                if name == i.make {
                    selectedCars.append(i)
                }
            }
    }
        self.navigationController?.pushViewController(vc, animated: true)
        print(selectedCars)
        vc.carArray = selectedCars

}
   
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
}
