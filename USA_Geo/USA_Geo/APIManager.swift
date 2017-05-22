//
//  APIManager.swift
//  USA_Geo
//
//  Created by MANISH on 15/05/17.
//  Copyright © 2017 Manish. All rights reserved.
//

import UIKit

class APIManager: NSObject {
    func getCountries(completion:(String?)->Void)->Void {
        // http://services.groupkt.com/country/get/all
        let urlStr = APIConstants.BASE_URL+"/"+APIConstants.GET_Countries
        guard let url = URL.init(string:urlStr)
        else{
            print("Error")
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (resData, resURL, resErr) in
            do{
                let parsedData = try JSONSerialization.jsonObject(with: resData!, options: JSONSerialization.ReadingOptions.allowFragments)
                print(parsedData)
            }catch{

            }
        }
        task.resume()
        
        completion("USA")
    }
    
    func getDetailForCountry(country:String) {
        // http://services.groupkt.com/state/get/IND/all
    }

}
