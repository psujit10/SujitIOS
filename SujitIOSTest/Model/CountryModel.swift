//
//  CountryModel.swift
//  SujitIOSTest
//
//  Created by Admin on 12/17/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
struct CountryModel{
    var title: String?
    var description: String?
    var imageHref: String?
    
    init(){
    }
    
    init(json:NSDictionary){
        title = json["title"] as? String
        imageHref = json["imageHref"] as? String
        // print("imageHref:--",imageHref)
        description = json["description"] as? String
        
    }
}

