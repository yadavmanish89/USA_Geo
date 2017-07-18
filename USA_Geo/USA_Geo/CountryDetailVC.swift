//
//  CountryDetailVC.swift
//  USA_Geo
//
//  Created by MANISH on 13/07/17.
//  Copyright © 2017 Manish. All rights reserved.
//

import UIKit

class CountryDetailVC: UIViewController {
    var country:String?
    var countryCode:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.country
        // Do any additional setup after loading the view.
        loadData()
    }

    func loadData() {
        let apiManager = APIManager.init()
        apiManager.getDetailForCountry(country: countryCode!) { (responseData) in
            
            print(responseData)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
