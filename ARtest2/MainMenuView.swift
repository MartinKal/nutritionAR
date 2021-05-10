//
//  MainMenuView.swift
//  ARtest2
//
//  Created by Martin Kalaydzhiev on 3/20/21.
//

import SwiftUI

struct MainMenuView: View {
    @State private var isShowingLibrary = false
    @State var image = UIImage()
    @State private var isShowingAR = false
    @State private var isShowingGame = false
    @ObservedObject var pViewModel = ProductViewModel.productViewModel
    @State private var selectedProduct1 = ProductViewModel.productViewModel.product1
    @State private var selectedProduct2 = ProductViewModel.productViewModel.product2
    @State private var animationAmount: CGFloat = 1
    
    @State private var products = [Product]()
    
    @State private var clickedOnCamera = false
    
    var body: some View {
        VStack {
            HStack{
                Text("Experience your Calories in AR")
                    .font(.title2)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    .foregroundColor(.blue)
                Spacer()
            }
            VStack {
                VStack(alignment: .leading) {
                    Picker("#1", selection: $selectedProduct1) {
                        ForEach(pViewModel.products, id: \.self) {
                            Text($0.product_name)
                        }
                    }
                    .frame(maxHeight: 120)
                }
                VStack(alignment: .leading) {
                    Picker("#2", selection: $selectedProduct2) {
                        ForEach(pViewModel.products, id: \.self) {
                            Text($0.product_name)
                        }
                    }
                    .frame(maxHeight: 120)
                }
            }
            HStack {
                Button {
                    isShowingLibrary = true
                    clickedOnCamera.toggle()
                } label: {
                    HStack {
                        Image(systemName: "camera")
                            .imageScale(.large)
                        Text("Scan barcode")
                    }
                }
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.red, lineWidth: 2)
                            .scaleEffect(animationAmount)
                            .opacity(Double(1.8 - animationAmount))
                            .animation(clickedOnCamera ? .none : Animation.easeOut(duration: 1.4)
                                        .repeatForever(autoreverses: true))
                )
                .onAppear {
                    animationAmount = 1.25
                }
                .sheet(isPresented: $isShowingLibrary) {
                    ImagePicker(selectedImage: $image, products: $pViewModel.products, sourceType: .camera)
                }
            }
            HStack {
                Button {
                    isShowingAR = true
                } label: {
                    HStack {
                        Image(systemName: "play")
                            .imageScale(.large)
                        Text("See in AR")
                    }
                }
                .padding()
                .background(Color.black)
                .foregroundColor(.blue)
                .clipShape(Capsule())
                .sheet(isPresented: $isShowingAR) {
                    ARDisplayView(product1: $selectedProduct1, product2: $selectedProduct2)
                }
                
                Button {
                    isShowingGame = true
                } label: {
                    Image(systemName: "play")
                        .imageScale(.large)
                    Text("Play Game!")
                }
                .padding()
                .sheet(isPresented: $isShowingGame) {
                    ARGameView()
                }
            }
        }
        .ignoresSafeArea(.all)
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
