//
//  ARDisplayView.swift
//  ARtest2
//
//  Created by Martin Kalaydzhiev on 3/12/21.
//

import SwiftUI
import UIKit
import RealityKit

struct ARDisplayView: View {
    @Binding var product1: Product
    @Binding var product2: Product
    var body: some View {
        ARViewContainer(product1: $product1, product2: $product2).edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    @Binding var product1: Product
    @Binding var product2: Product
    
    func makeUIView(context: Context) -> ARView {
        return ARModel.spawn(product1: product1, product2: product2)
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
    }
}


struct ARDisplayView_Previews: PreviewProvider {
    @State static var p1 = Product(nutriments: Nutriments(fat: 15, fiber: 0, sugars: 20, energy: 600, carbohydrates: 10, proteins: 12), product_name: "p1")
    @State static var p2 = Product(nutriments: Nutriments(fat: 21, fiber: 0, sugars: 17, energy: 850, carbohydrates: 14, proteins: 9), product_name: "p2")
    static var previews: some View {
        ARDisplayView(product1: $p1, product2: $p2)
    }
}

