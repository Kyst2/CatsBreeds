import SwiftUI

struct CatItem: View {
    @ObservedObject var model: CatItemViewModel
    
    init(cat: CatBreed) {
        model = CatItemViewModel(cat: cat)
    }
    
    var body: some View {
        Button(action: { model.descrShown.toggle() } ) { Label() }
            .sheet(isPresented: $model.descrShown) {
                DetailsSheet()
            }
    }
    
    func Label() -> some View {
        VStack {
            if let image = model.img {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150 , height: 150)
                    .mask( RoundedRectangle(cornerRadius: 7) )
            } else {
                ProgressView()
                    .frame(width: 150 , height: 150)
            }
            
            Text(model.cat.name)
                .font(.headline)
                .lineLimit(1)
                .truncationMode(.tail)
                .padding(.horizontal, 10)
            
            Spacer()
        }
        .task {
            await model.reloadImg()
        }
    }
    
    func DetailsSheet() -> some View {
        VStack {
            if let image = model.img {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .mask( RoundedRectangle(cornerRadius: 7) )
            } else {
                ProgressView()
            }
            
            Text(model.cat.description)
                .font(.caption)
                .padding()
            
            //add more details
            Spacer()
        }
    }
}
