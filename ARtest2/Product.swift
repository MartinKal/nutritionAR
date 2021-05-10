//
//  Product.swift
//  ARtest2
//
//  Created by Martin Kalaydzhiev on 3/14/21.
//

import Foundation

struct ProductInfo: Codable {
    var product: Product?
    var status: Int
    //var image_url: String
}

struct Product: Codable, Hashable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        return rhs.product_name == lhs.product_name
    }
    
    //var nutrient_levels: NutrientLevels?
    var nutriments: Nutriments
    //var product_quantity: Int
    //var generic_name: String
    var product_name: String
    
    
}

struct NutrientLevels: Codable {
    //var saturatedFat: String
    var fat: String
    var sugars: String
    
    init(f: String, s: String) {
        fat = f
        sugars = s
    }
    //var salt: String
    /*
    enum CodingKeys: String, CodingKey {
        //case saturatedFat = "saturated-fat"
        case fat
        case sugars
        //case salt
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        saturatedFat = try values.decode(String.self, forKey: .saturatedFat)
        fat = try values.decode(String.self, forKey: .fat)
        sugars = try values.decode(String.self, forKey: .sugars)
        salt = try values.decode(String.self, forKey: .salt)
    }*/
}

struct Nutriments: Codable, Hashable {
    var fat: Double = 0
    var fiber: Double = 0
    var sugars: Double = 0
    var energy: Int = 0
    var carbohydrates: Double = 0
    var proteins: Double = 0
    var cals: Int {
        Int(Double(energy) / 4.184)
    }
    
    func info() -> String {
        return "fat: \(fat), sugar: \(sugars), carbs: \(carbohydrates), protein: \(proteins), cals: \(cals)"
    }
}

