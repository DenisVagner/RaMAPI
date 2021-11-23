import Foundation

struct AllCharacters: Decodable {
    var results: [CharacterInfo]
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
