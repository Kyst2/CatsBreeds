import Foundation
import SwiftUI

class CatsBreedsParser {
    //треба або асинхронна функція або повертати резалти/future(ліпше)
    func getAllCatsInfo() async -> [CatBreed]? {
        guard let url = URL(string: "https://api.thecatapi.com/v1/breeds") else { return nil }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let json = String(data: data, encoding: .utf8) else { return nil }
            
            let a = json.decodeFromJson(type: [CatBreed].self)
            
            return try a.get()
        } catch {
            print(error)
        }
        
        return nil
    }
}

extension CatBreed {
    func getImage() async throws -> UIImage? {
        guard let imgId = self.reference_image_id,
              let url = URL(string: "https://api.thecatapi.com/v1/images/\(imgId)")
        else { return nil }
        
        
        
        
        return nil
    }
}
