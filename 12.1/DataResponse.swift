//
//  Dateresponse.swift
//  12.1
//
//  Created by Денис Вагнер on 17.11.2021.
//

import Foundation

struct DataResponse1: Decodable {
    var id: Int
    var name: String
    var status: String
    var species: String
    var location: LocationInfo
    var image: String
}

struct LocationInfo: Decodable {
    var name: String
    //var url: String
}
