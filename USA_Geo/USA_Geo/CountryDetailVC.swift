//
//  CountryDetailVC.swift
//  USA_Geo
//
//  Created by MANISH on 13/07/17.
//  Copyright © 2017 Manish. All rights reserved.
//

import UIKit

class CountryDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var stateTableView: UITableView!
    var country:String?
    var countryCode:String?
    var statesArr = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.country
        // Do any additional setup after loading the view.
        loadData()
    }
    func loadData() {
        let apiManager = APIManager.init()
//        countryCode = "IND"
        apiManager.getDetailForCountry(country: countryCode!) { [unowned self](responseData) in
            guard let restResponse = responseData?.object(forKey: "RestResponse") as? NSDictionary else{
                return
            }
            guard let results = restResponse.object(forKey: "result") as? NSArray else{
                return
            }
            for stateObj in results{
                guard let stateDict = stateObj as? NSDictionary else{
                    return
                }
                self.statesArr.append(stateDict.object(forKey: "name") as! String)
            }
            if self.statesArr.count == 0{
                let alert = UIAlertController.init(title: "No Details Found.", message: nil, preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction.init(title: "Ok", style: UIAlertActionStyle.cancel, handler: { (okAlert) in
                        self.navigationController?.popViewController(animated: true)
                })
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
            self.stateTableView.reloadData()
        }
    }
    
    //MARK: TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "DetailCell")
        cell.textLabel?.text = statesArr[indexPath.row]
        return cell
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
