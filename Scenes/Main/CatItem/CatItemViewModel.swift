import SwiftUI

class CatItemViewModel: ObservableObject {
    let cat: CatBreed
    @Published var img: UIImage?
    @Published var descrShown: Bool = false
    
    init(cat: CatBreed) {
        self.cat = cat
    }
    
    func reloadImg() async {
        guard img == nil else { return }
        
        do {
            let img = try await cat.getImage()
            
            DispatchQueue.main.async {
                self.img = img
            }
        } catch {
            fatalError("NOT IMPLEMENTED")
        }
    }
}
