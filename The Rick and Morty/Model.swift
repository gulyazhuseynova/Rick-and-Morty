//
//  Model.swift
//  The Rick and Morty
//
//  Created by Gulyaz Huseynova on 26.09.22.
//

import Foundation

struct ApiData : Codable {
    let info: Info?
    let results: [Results?]
}

struct Info : Codable {
    let pages : Int?
}

struct Results : Codable {
    let id: Int?
    let name : String?
    let status : String?
    let species : String?
    let type : String?
    let gender : String?
    let origin : Origin?
    let location : Location?
    let image : URL?
    let episode : [String?]
    
}

struct Origin : Codable {
    let name : String?
    let url : String?
}

struct Location : Codable {
    let name : String?
    let url : String?
}

struct ApiDataEpisode : Codable {
    let name: String?
    let air_date: String?
    let episode: String?
}

struct ApiDataLocation : Codable {
    let name : String?
    let type : String?
    let dimension : String?
}

struct PopUpViewData {
    let imageName: String
    let heading1: String
    let body1: String
    let heading2: String
    let body2: String
    let heading3: String
    let body3: String
    let headingColor: String
    let bodyColor: String
}
