//
//  ViewController.swift
//  USA_Geo
//
//  Created by MANISH on 11/05/17.
//  Copyright © 2017 Manish. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    var dataArray = [CountryModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadData()
    }

    func loadData() {
        let apiManager = APIManager.init()
        apiManager.getCountries { (response) in
            if let respDict:NSDictionary = response as? NSDictionary{
                self.parseData(respDict: respDict)
            }

            if let resp = response{
            print("API Response:\(resp)")
            }
            else{
                print("Error")
            }
        }
    }
    
    func parseData(respDict:NSDictionary) {
        let restResponse:NSDictionary? = respDict.object(forKey:"RestResponse") as? NSDictionary
        if let resultArray:NSArray = restResponse?.object(forKey: "result") as? NSArray{
            for obj in resultArray {
                if let objDict:NSDictionary = obj as? NSDictionary{
                    let country:CountryModel = CountryModel.init()
                    country.parseObject(objDict: objDict)
                    country.name = objDict.object(forKey: "name") as? String
                    dataArray.append(country)
                }
            }
        }
        tableView.reloadData()
    }
    
    //MARK: Table Delegates
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "myCell")
        let country:CountryModel = dataArray[indexPath.row] 
        cell.textLabel?.text = country.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let apiManager = APIManager.init()
        apiManager.getCountries { (response) in
            if let resp = response{
                print("Response:\(resp)")
            }
            else{
                print("Error")
            }
        }
    }
    
    deinit {
        print("hey")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

