//
//  LogginEntity.swift
//  appBiblioteca
//
//  Created by DAMII on 10/11/23.
//

import UIKit

struct LogginEntity:Encodable{
    
    var username:String
    var password:String
    
    enum CodingKeys: String, CodingKey {
           case username
           case password
       }
}
