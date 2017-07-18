//
//  APIManager.swift
//  USA_Geo
//
//  Created by MANISH on 15/05/17.
//  Copyright © 2017 Manish. All rights reserved.
//

import UIKit

class APIManager: NSObject {
    func getCountries(completion: @escaping (Any?)->Void) {
        // http://services.groupkt.com/country/get/all
        let urlStr = APIConstants.BASE_URL+APIConstants.GET_Countries
        guard let url = URL.init(string:urlStr)
        else{
            print("Error")
            return
        }
        let session = URLSession.shared        
        let task = session.dataTask(with: url) { (resData, resURL, resErr) in
            if let error = resErr{
                print("Error :\(error.localizedDescription)")
            }
            else if let data = resData{
                do{
    
                    let parsedData = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.allowFragments)
                    if let responseDict = parsedData as? NSDictionary{
                        DispatchQueue.main.async {
                            completion(responseDict)
                        }
                    }
                }catch{
                    
                }
            }
            else{
                print("Response is of not type 'Data'")
            }
        }
        task.resume()
    }
    
    func playWithDispatchQueue() {
        let myQ = DispatchQueue(label: "com.swift.myQ")
        myQ.async {
            let name = String(cString: __dispatch_queue_get_label(nil), encoding: .utf8)
            print("MyQueue:\(String(describing: name))")
        }
        
        DispatchQueue.global(qos:.default).async{
            let name = String(cString: __dispatch_queue_get_label(nil), encoding: .utf8)
            print("GlobalQueue:\(String(describing: name))")
            
        }
    }
    
    func getDetailForCountry(country:String,completion:@escaping (Any?)->Void) {
        // http://services.groupkt.com/state/get/IND/all
        let urlStr = BASE_URL+APIConstants.GET_CountryDetail+country+"/all"
        guard let url = URL.init(string: urlStr) else {
            print("Error in url")
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (resData, response, err) in
            if let error = err{
                print("Error :\(error.localizedDescription)")
            }
            else if let data = resData {
                do{
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                    if let responseDict = json as? NSDictionary{
                        DispatchQueue.main.async {
                        completion(responseDict)
                        }
                    }
                }
                catch{
                    
                }
            }
        }
        task.resume()
    }

}
