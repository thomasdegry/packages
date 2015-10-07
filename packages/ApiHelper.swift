//
//  ApiHelper.swift
//  packages
//
//  Created by LOANER on 10/6/15.
//  Copyright © 2015 Thomas Degry. All rights reserved.
//

import Foundation
import Alamofire

let apiBaseUrl = "https://isl-api.herokuapp.com/api"
let apiHeaders = [
    "Authorization": "Token ade099854ae8d4ef3fb42e576eff6f4e62ddbc2b"
]

class ApiHelper {
    class func getContactsFromApi(completionHandler: (contacts: [Contact]) -> ()) {
        
        Alamofire.request(.GET, apiBaseUrl + "/employees", headers: apiHeaders).responseJSON { response in
            debugPrint(response)
        }
        
    }
}