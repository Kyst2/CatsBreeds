import SwiftUI

struct MainView: View {
    @StateObject var model = MainViewModel()
    
    let columns = (1...2).map { _ in GridItem(.flexible()) }
    
    var body: some View {
        ScrollView {
            Section("Cats") {
                if let allCats = model.allCats {
                    LazyVGrid(columns: columns) {
                        ForEach(allCats) { cat in
                            CatItem(cat: cat)
                        }
                    }
                } else {
                    ProgressView()
                }
            }
            
        }.padding(.top,15)
        .task {
            await model.loadData()
        }
    }
}
