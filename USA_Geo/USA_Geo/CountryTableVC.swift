//
//  ViewController.swift
//  USA_Geo
//
//  Created by MANISH on 11/05/17.
//  Copyright © 2017 Manish. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadData()
    }

    func loadData() {
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
    
    //MARK: Table Delegates
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "myCell")
        cell.textLabel?.text = "hey"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let url = URL.init(string:"APICon@#$%stants")
            else{
                print("Error")
                return
        }
        print("URL is:\(url)")

        print("DidSelect")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

