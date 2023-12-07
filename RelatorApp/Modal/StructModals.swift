//
//  StructModals.swift
//  RelatorApp
//
//  Created by Pavan Pullugundla on 11/2/23.
//


import Foundation
struct SearchStruct: Codable
{
    let status : Bool?
    let message : String?
    let timestamp : Int?
    let data : [searchdata]?
    struct  searchdata  : Codable {
        let price : String?
        let publicAddress : String?
        let city : String?
        let title : String?
        let avgRatingLocalized : String?
        let roomType: String?
        let spaceType : String?
        let images : [String]?
        
    
        let location : Location?
        
        struct Location: Codable {
            let mapBoundsHint: MapBoundsHint?
            struct MapBoundsHint: Codable {
                let northeast: Coordinate?
                let southwest: Coordinate?
                struct Coordinate: Codable {
                    let latitude: Double?
                    let longitude: Double?
                }
            }
            
        }
    }
    
    
    
}


struct PlaceStruct: Codable
{
    let status : Bool?
    let message : String?
    let timestamp : Int?
    let data : [Placedata]?
    struct  Placedata  : Codable {
        let id: String?
        let location_name : String?
        let country_code : String?
        
    }
}
