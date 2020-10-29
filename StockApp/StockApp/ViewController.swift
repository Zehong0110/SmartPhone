//
//  ViewController.swift
//  StockApp
//
//  Created by 沈泽洪 on 10/26/20.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftSpinner

class ViewController: UIViewController {
    
    @IBOutlet weak var txtStockName: UITextField!
    
    
    @IBOutlet weak var lblCeo: UILabel!
    
    
    @IBOutlet weak var lblPrice: UILabel!
    
    
    let apiKey = "a701c8da8beb394f2d190c9a62990458"
    let apiURL = "https://financialmodelingprep.com/api/v3/profile/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func getValue(_ sender: Any) {
    
        guard let stockName = txtStockName.text else { return }
        
        print(stockName)
        
        let url = "\(apiURL)\(stockName)?apikey=\(apiKey)"
        
        getStockValue(stockURL: url, stockName: stockName)
        
    }
    
    func getStockValue(stockURL : String!, stockName : String!)  {
        SwiftSpinner.show("Getting Stock Value for \(String(describing: stockName))")
        AF.request(stockURL).responseJSON {(response) in
            SwiftSpinner.hide()
             
            if response.error == nil{
                guard let jsonString = response.data else { return }
                
                guard let stockJSON: [JSON] = JSON(jsonString).array else { return }
                
                if stockJSON.count < 1 { return }
                guard let symbol = stockJSON[0]["symbol"].rawString() else { return }
                guard let price = stockJSON[0]["price"].double  else { return }
                guard let ceo = stockJSON[0]["ceo"].rawString() else { return }
                
                
                self.lblPrice.text = "\(price)"
                self.lblCeo.text = ceo
            }
        }
    }

}

