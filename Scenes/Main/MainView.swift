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
        }
        .padding(.top,15)
        .task {
            await model.loadData()
        }
        .onReceive(orientationChanged) { _ in
            columns = UIDevice.current.orientation.isLandscape ? columnsLandscape : columnsPortrait
        }
    }
}
