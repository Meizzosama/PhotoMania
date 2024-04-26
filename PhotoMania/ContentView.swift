//
//  ContentView.swift
//  PhotoMania
//
//  Created by DC on 26/04/2024.
//

import SwiftUI


// https://random.imagecdn.app/500/500

class ViewModel: ObservableObject{
    @Published var image: Image?
    
    func fetchNewImage(){
        guard let url = URL(string: "https://random.imagecdn.app/500/500")
        else {
            return
        }
        let task = URLSession.shared.dataTask(with: url){
            data, _, _ in
            guard let data = data else {return}
            DispatchQueue.main.async {
                guard let uiImage = UIImage(data: data) else{
                    return
                }
                self.image = Image(uiImage: uiImage)
            }
        }
        task.resume()
    }
}

struct ContentView: View {
    
   @StateObject var viewModel = ViewModel()
    
    
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                if let image = viewModel.image{
                    ZStack{
                        image.resizable()
                            .foregroundColor(.cyan)
                            .frame(width: 300,height: 300)
                        .padding()}.frame(width: UIScreen.main.bounds.width / 1.2,
                                          height:UIScreen.main.bounds.width / 1.2)
                        .background(Color.gray)
                        .cornerRadius(8)
                }else{
                    Image(systemName: "photo").resizable()
                        .foregroundColor(.cyan)
                        .frame(width: 300,height: 300)
                        .padding()
                }
                
                
                Spacer()
                Button(action: {
                    viewModel.fetchNewImage()
                }, label: {
                    Text("Click Here").bold()
                        .frame(width: 250,height: 55)
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8).padding()
                })
            }
            .navigationBarTitle("Photo Mania",displayMode: .automatic)
        }
    }
}

#Preview {
    ContentView()
}
