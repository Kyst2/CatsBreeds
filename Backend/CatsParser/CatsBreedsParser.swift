import Foundation
import SwiftUI

struct CatError : Error {
    var localizedDescription : String
    init(_ desc: String) {
        localizedDescription = desc
    }
}

class CatsBreedsParser {
    static func getAllCatsInfo() async -> Result<[CatBreed], Error> {
        guard let url = URL(string: "https://api.thecatapi.com/v1/breeds") else { return .failure(CatError("Incorrect url")) }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            guard let json = String(data: data, encoding: .utf8) else { return .failure(CatError("Failed to parse Json")) }
            
            return json.decodeFromJson(type: [CatBreed].self)
        } catch {
            print(error)
        }
        
        return .failure(CatError("WTF???"))
    }
    
    static func getURLImage(catID: String) async -> [CatImage]? {
        guard let url = URL(string: "https://api.thecatapi.com/v1/images/search?breed_ids=\(catID)") else { return nil}
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            guard let json = String(data: data, encoding: .utf8) else { return nil }
            
            let a = json.decodeFromJson(type: [CatImage].self)
            
            return try a.get()
        } catch {
            print(error)
        }
        
        return nil
    }
    
    static func getCatImg(catID: String) async throws -> UIImage? {
        let catImageUrl = await CatsBreedsParser.getURLImage(catID: catID)?.first?.url
        guard let catImageUrl = catImageUrl else { return nil }
        
        if let img = ImgsCache.shared.getImg(id: catImageUrl) {
            return img
        }
        
        guard let url = URL(string: catImageUrl) else { return nil }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        guard let image = UIImage(data: data) else { return nil }
        
        ImgsCache.shared.saveImg(id: catImageUrl, img: image)
        
        return image
    }
}

extension CatBreed {
    func getImage() async throws -> UIImage? {
        try await CatsBreedsParser.getCatImg(catID: self.id)
    }
}

struct CatImage: Codable {
    let id: String
    let url: String
    let width: Int
    let height: Int
}
