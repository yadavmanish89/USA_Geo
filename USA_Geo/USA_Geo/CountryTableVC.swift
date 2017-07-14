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
//        loadData()
//        readLocalJson()
        do{
             try readJsonWithThrow()
        }
        catch{
            
        }
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
    
    func readJsonWithThrow() throws{
        guard let filePath = Bundle.main.path(forResource: "DummyData", ofType: "geojson")else {
            throw JsonError.FilePathNotFound
        }
        do{
            let jsonData = try Data.init(contentsOf: URL.init(fileURLWithPath: filePath))
            let result = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments)
            if let respDict:NSDictionary = result as? NSDictionary{
                do{
                    try parseJsonUsingGuard(response: respDict)
                }
                catch let err{
                    switch err {
                    case JsonError.DataNotFound:
                        print("Data not found")
                    case JsonError.ObjectNotArray:
                        print("Not an Array")
                    case JsonError.ObjectNotDictionary:
                        print("Not an Dict")
                    default:
                        print("unknown problem")
                    }
                    print("Error while parsing:\(err)")
                }
            }
        }
        catch let err{
            print("Error while serialization:\(err.localizedDescription)")
        }
    }
    func parseJsonUsingGuard(response:NSDictionary) throws {
        guard let restResponse = response.object(forKey:"RestResponse") as? NSDictionary else {
            throw JsonError.ObjectNotDictionary
        }
        guard let resultArray = restResponse.object(forKey:"result") as? NSArray else {
            throw JsonError.ObjectNotArray
        }
        for obj in resultArray {
            if let objDict:NSDictionary = obj as? NSDictionary{
                let country:CountryModel = CountryModel.init()
                country.parseObject(objDict: objDict)
                country.name = objDict.object(forKey: "name") as? String
                dataArray.append(country)
            }
        }
        tableView.reloadData()
    }

    func readLocalJson()  {
        
        let filePath = Bundle.main.path(forResource: "DummyData", ofType: "geojson")
        do {
            let jsonData1 = try Data.init(contentsOf: URL.init(fileURLWithPath: filePath!))
            let result = try JSONSerialization.jsonObject(with: jsonData1, options: JSONSerialization.ReadingOptions.allowFragments)
            if let respDict:NSDictionary = result as? NSDictionary{
                self.parseData(respDict: respDict)
            }
        } catch let erro {
            print("Data error:\(erro.localizedDescription)")
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

