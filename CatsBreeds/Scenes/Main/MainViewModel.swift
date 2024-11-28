import Foundation

class MainViewModel: ObservableObject {
    @Published var allCats: Result<[CatBreed], Error> = .success([])
    
    func loadData() async {
        let newBreeds = await CatsBreedsParser.getAllCatsInfo()
        
        DispatchQueue.main.async {
            self.allCats = newBreeds
        }
    }
}
