//
//  CountryModel.swift
//  USA_Geo
//
//  Created by MANISH on 03/06/17.
//  Copyright © 2017 Manish. All rights reserved.
//

import UIKit

class CountryModel: NSObject {
    var name:String?
    var code:String?

    func parseObject(objDict:NSDictionary?)  {
        code = objDict?.object(forKey: "alpha3_code") as? String
    }
}
