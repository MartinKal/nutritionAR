//
//  ContentView.swift
//  ARtest2
//
//  Created by Martin Kalaydzhiev on 3/11/21.
//

import SwiftUI
import RealityKit
import UIKit

struct ContentView : View {
    @State private var barcode = ""
    @State private var isShowingLibrary = false
    @State var image = UIImage()
    @State private var showAR = false
    @ObservedObject var pViewModel = ProductViewModel.productViewModel
    
    var body: some View {
        MainMenuView()
    }
    
    func loadData(completion: @escaping (Product) -> ()) {
        let s = "https://world.openfoodfacts.org/api/v0/product/" + barcode + ".json"
        //let s1 = "https://itunes.apple.com/search?term=taylor+swift&entity=song"
        guard let url = URL(string: s) else {
            print("invalid url")
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let res = try? decoder.decode(ProductInfo.self, from: data) {
                    DispatchQueue.main.async {
                        pViewModel.product1 = res.product ?? Product(nutriments: Nutriments(fat: 0, fiber: 0, sugars: 0, energy: 0, carbohydrates: 0, proteins: 0), product_name: "")
                        completion(pViewModel.product1)
                    }
                } else {
                    print("No info for this product")
                }
            }
        }
        task.resume()
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
