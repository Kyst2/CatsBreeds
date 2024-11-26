import Foundation

struct CatInfo: Codable {
    let id: String
    let width: Int
    let height: Int
    let url: String
    let breeds: [Breed]
}

struct Breed: Codable {
    let weight: Weight
    let id: String
    let name: String
    let temperament: String
    let origin: String
    let countryCodes: String
    let countryCode: String
    let lifeSpan: String
    let wikipediaURL: String?
}

struct Weight: Codable {
    let imperial: String
    let metric: String
}
