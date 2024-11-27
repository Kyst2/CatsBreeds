import Foundation

class CatsAndDogParser {
    func getAllCatsInfo() -> [CatBreed]? {
        let url = "https://api.thecatapi.com/v1/breeds".asURL()
        
        do {
            let contents = try String(contentsOf: url, encoding: .ascii)
            
            let a = contents.decodeFromJson(type: [CatBreed].self)
            
            return try a.get()
        } catch { }
        
        return nil
    }
}

extension String {
    func asURL() -> URL {
        return URL(string: self)!
    }
}
