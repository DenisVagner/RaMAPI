import Foundation

struct AllCharacters: Decodable {
    var info: totalInfo
    var results: [CharacterInfo]
}

struct totalInfo: Decodable {
    var count: Int
    var pages: Int
    var next: String?
    var prev: String?
}

struct CharacterInfo: Decodable {
    var id: Int
    var name: String
    var status: String
    var species: String
    var location: LocationInfo
    var image: String
}

struct LocationInfo: Decodable {
    var name: String
    var url: String
}
