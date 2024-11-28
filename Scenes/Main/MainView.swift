import SwiftUI

fileprivate let columnsPortrait = (1...2).map { _ in GridItem(.flexible()) }
fileprivate let columnsLandscape = (1...4).map { _ in GridItem(.flexible()) }

struct MainView: View {
    @StateObject var model = MainViewModel()
    
    private let orientationChanged = NotificationCenter.default
            .publisher(for: UIDevice.orientationDidChangeNotification)
            .makeConnectable()
            .autoconnect()
    
    @State var columns: [GridItem] = columnsPortrait
    
    var body: some View {
        ScrollView {
            switch model.allCats {
            case .success(let catsBreeds):
                ListOfBreeds(catsBreeds)
            case .failure(let error):
                ErrorView(error)
            }
        }
        .padding(.top,15)
        .task {
            await model.loadData()
        }
        .onReceive(orientationChanged) { _ in
            columns = UIDevice.current.orientation.isLandscape ? columnsLandscape : columnsPortrait
        }
    }
    
    func ListOfBreeds(_ catsBreeds: [CatBreed]) -> some View {
        Section("Cats") {
            if catsBreeds.count == 0 {
                ProgressView()
            } else {
                LazyVGrid(columns: columns) {
                    ForEach(catsBreeds) { cat in
                        CatItem(cat: cat)
                    }
                }
            }
        }
    }
    
    func ErrorView(_ error: Error) -> some View {
        VStack{
            Text("Error occured: \(error)")
            
            Button("Reload") {
                
            }
        }
    }
}
