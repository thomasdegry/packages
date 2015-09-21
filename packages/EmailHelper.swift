//
//  EmailHelper.swift
//  packages
//
//  Created by LOANER on 8/26/15.
//  Copyright (c) 2015 Thomas Degry. All rights reserved.
//

import Foundation
import Alamofire

class EmailHelper {
    
    func sendPickUpEmailTo(employee: Employee) {
        Alamofire.request(.POST, "https://mandrillapp.com/api/1.0/messages/send-template.json",
            parameters: mandrillVarsForEmployee(employee), encoding: ParameterEncoding.JSON, headers: nil).response {
                request, response, data, error in
            print(request)
            print(response)
            print(error)
        }
    }
    
    func mandrillVarsForEmployee(employee: Employee) -> [String: AnyObject] {
        
        return [
            "key" : "fzqml666hIkK5fem6YncLg",
            "template_name": "package-notification",
            "template_content": [
                [
                    "name": "",
                    "content": ""
                ]
            ],
            "message": [
                "from_email": "ops@isl.co",
                "to": [
                    [
                        "email": employee.email,
                        "name": employee.name,
                        "type": "to"
                    ]
                ],
                "headers": [
                    "Reply-To": "ops@isl.co"
                ],
                "important": false,
                "track_opens": true,
                "track_clicks": true,
                "auto_text": false,
                "auto_html": false,
                "inline_css": true,
                "preserve_recipients": false,
                "view_content_link": false,
                "merge": true,
                "merge_language": "mailchimp",
                "merge_vars": [
                    [
                        "rcpt": employee.email,
                        "vars": [
                            [
                                "name": "EMPLOYEE_NAME",
                                "content" : employee.name
                            ]
                        ]
                    ]
                ],
                "tags": [
                    "selfie", "selfie mirror", "courtyard selfie"
                ],
                "metadata": [
                    "website": "www.courtyard.com"
                ]
            ],
            "async": false,
            "ip_pool": "Main Pool"
        ]
        
    }
    
}
