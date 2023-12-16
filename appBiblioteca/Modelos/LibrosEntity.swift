//
//  LibrosEntity.swift
//  appBiblioteca
//
//  Created by DAMII on 13/11/23.
//

import UIKit

struct LibrosEntity: Codable{
    
    var id: Int
    var titulo: String
    var descripcion: String
    var autor:String
    var archivo: String
    var portada: String
    var registro: String
    var estado : Bool
    var genero: GeneroEntity
    //pruebaaaa
}
