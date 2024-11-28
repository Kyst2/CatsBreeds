import Foundation

class MainViewModel: ObservableObject {
    @Published var allCats: [CatBreed]?
    
    func loadData() async {
        if let newBreeds = await CatsBreedsParser.getAllCatsInfo(), allCats == nil {
            DispatchQueue.main.async {
                if self.allCats != newBreeds {
                    self.allCats = newBreeds
                }
            }
        }
    }
}
