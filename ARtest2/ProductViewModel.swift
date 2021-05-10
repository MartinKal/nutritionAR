//
//  ProductViewModel.swift
//  ARtest2
//
//  Created by Martin Kalaydzhiev on 3/14/21.
//

import Foundation


final class ProductViewModel: ObservableObject {
    @Published var product1 = Product(nutriments: Nutriments(fat: 23, fiber: 1, sugars: 29, energy: 2100, carbohydrates: 60, proteins: 12), product_name: "Product1")
    @Published var product2 = Product(nutriments: Nutriments(fat: 19, fiber: 1, sugars: 24, energy: 2402, carbohydrates: 64, proteins: 18), product_name: "Product2")
    static let productViewModel = ProductViewModel()
    @Published var products = [Product]()
    
    private init() {
        
    }
}
