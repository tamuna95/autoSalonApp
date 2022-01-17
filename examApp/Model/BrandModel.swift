//
//  BrandModel.swift
//  examApp
//
//  Created by APPLE on 23.12.21.
//

import Foundation

//struct BrandRequest : Codable {
//    var brand : [Brand]!
//    
//}

struct Brand : Codable {
    var year : Int!
    var id : Int!
    var horsepower : Int!
    var make : String!
    var model : String!
    var price : Int!
    var img_url : String
    var amount : Int
    }


struct OldBrand : Codable {
    var year : Int!
    var id : Int!
    var horsepower : Int!
    var make : String!
    var model : String!
    var price : Int!
    var img_url : String
    
    }
