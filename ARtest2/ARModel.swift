//
//  ARModel.swift
//  ARtest2
//
//  Created by Martin Kalaydzhiev on 3/12/21.
//

import SwiftUI
import RealityKit

final class ARModel: ObservableObject {
    static var shared = ARModel()
    static var coordinates1 = [
        "fat": Coordinates(x: 0, y: 0.005, z: -0.20),
        "sugar": Coordinates(x: 0.13, y: 0.005, z: -0.20),
        "protein": Coordinates(x: -0.26, y: 0.005, z: -0.20),
        "carb": Coordinates(x: -0.13, y: 0.005, z: -0.20),
        "cal": Coordinates(x: 0.26, y: 0.005, z: -0.20),
    ]
    
    static var coordinates2 = [
        "protein": Coordinates(x: -0.2597, y: 0.005, z: -0.0306),
        "carb": Coordinates(x: -0.1256, y: 0.005, z: -0.0306),
        "fat": Coordinates(x: 0, y: 0.005, z: -0.0306),
        "sugar": Coordinates(x: 0.1324, y: 0.005, z: -0.0306),
        "cal": Coordinates(x: 0.26, y: 0.005, z: -0.0306)
    ]
    
    init() {}
    
    static func spawn(product1: Product, product2: Product) -> ARView {
        let arView = ARView(frame: .null)
        let anchor = try! Experience.loadBox()
        arView.scene.anchors.append(anchor)
        
        let fatBig = anchor.fat1
        let fatSmall = anchor.fat2
        let proteinBig = anchor.protein1
        let proteinSmall = anchor.protein2
        let carbBig = anchor.carbs1
        let carbSmall = anchor.carbs2
        let sugarBig = anchor.sugar1
        let sugarSmall = anchor.sugar2
        let calBig = anchor.cal1
        let calMed = anchor.cal2
        let calSmall = anchor.cal3
        
        var p1BigFat = [Entity?]()
        var p2BigFat = [Entity?]()
        var p1SmallFat = [Entity?]()
        var p2SmallFat = [Entity?]()
        
        var p1BigProtein = [Entity?]()
        var p1SmallProtein = [Entity?]()
        var p2BigProtein = [Entity?]()
        var p2SmallProtein = [Entity?]()
        
        var p1BigSugar = [Entity?]()
        var p1SmallSugar = [Entity?]()
        var p2BigSugar = [Entity?]()
        var p2SmallSugar = [Entity?]()
        
        var p1BigCarb = [Entity?]()
        var p1SmallCarb = [Entity?]()
        var p2BigCarb = [Entity?]()
        var p2SmallCarb = [Entity?]()
        
        var p1BigCal = [Entity?]()
        var p1SmallCal = [Entity?]()
        var p2BigCal = [Entity?]()
        var p2SmallCal = [Entity?]()
        var p1MedCal = [Entity?]()
        var p2MedCal = [Entity?]()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            ARModel.spawnNutrient(amount: Int(product1.nutriments.proteins), listB: &p1BigProtein, listS: &p1SmallProtein, bigE: proteinBig!, smallE: proteinSmall!, c: ARModel.coordinates1["protein"]!, anchor: anchor)
            
            ARModel.spawnNutrient(amount: Int(product2.nutriments.proteins), listB: &p2BigProtein, listS: &p2SmallProtein, bigE: proteinBig!, smallE: proteinSmall!, c: ARModel.coordinates2["protein"]!, anchor: anchor)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            ARModel.spawnNutrient(amount: Int(product1.nutriments.carbohydrates), listB: &p1BigCarb, listS: &p1SmallCarb, bigE: carbBig!, smallE: carbSmall!, c: ARModel.coordinates1["carb"]!, anchor: anchor)
            ARModel.spawnNutrient(amount: Int(product2.nutriments.carbohydrates), listB: &p2BigCarb, listS: &p2SmallCarb, bigE: carbBig!, smallE: carbSmall!, c: ARModel.coordinates2["carb"]!, anchor: anchor)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
            ARModel.spawnNutrient(amount: Int(product1.nutriments.fat), listB: &p1BigFat, listS: &p1SmallFat, bigE: fatBig!, smallE: fatSmall!, c: ARModel.coordinates1["fat"]!, anchor: anchor)
            ARModel.spawnNutrient(amount: Int(product2.nutriments.fat), listB: &p2BigFat, listS: &p2SmallFat, bigE: fatBig!, smallE: fatSmall!, c: ARModel.coordinates2["fat"]!, anchor: anchor)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 9) {
            ARModel.spawnNutrient(amount: Int(product1.nutriments.sugars), listB: &p1BigSugar, listS: &p1SmallSugar, bigE: sugarBig!, smallE: sugarSmall!, c: ARModel.coordinates1["sugar"]!, anchor: anchor)
            ARModel.spawnNutrient(amount: Int(product2.nutriments.sugars), listB: &p2BigSugar, listS: &p2SmallSugar, bigE: sugarBig!, smallE: sugarSmall!, c: ARModel.coordinates2["sugar"]!, anchor: anchor)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 11) {
            spawnCalories(amount: product1.nutriments.cals, listB: &p1BigCal, listM: &p1MedCal, listS: &p1SmallCal, bigE: calBig!, mediumE: calMed!, smallE: calSmall!, c: ARModel.coordinates1["cal"]!, anchor: anchor)
            spawnCalories(amount: product2.nutriments.cals, listB: &p2BigCal, listM: &p2MedCal, listS: &p2SmallCal, bigE: calBig!, mediumE: calMed!, smallE: calSmall!, c: ARModel.coordinates2["cal"]!, anchor: anchor)
        }
        let chart1 = anchor.chart1
        let chart2 = anchor.chart2
        let chart3 = anchor.chart3
        
        //chart1!.scale = [5, 5, 5]
        print(chart1!.children[11])
        var material = SimpleMaterial()
        material.baseColor = .color(.white)

        //set charts
        setTagsToChart(chart: chart1!, material: material)
        setTagsToChart(chart: chart2!, material: material)
        setTagsToChart(chart: chart3!, material: material)

        // bar text
        setBarValues(chart: chart1!, material: material, nutriments: product1.nutriments)
        setBarValues(chart: chart2!, material: material, nutriments: product2.nutriments)
        setBarValues(chart: chart3!, material: material, nutriments: Nutriments(fat: 70, fiber: 1, sugars: 90, energy: 8372, carbohydrates: 260, proteins: 50))

        //scale bars chart1
        chart1!.children[6].scale = [1, 0.0909 * Float(0.8) * Float(product1.nutriments.proteins), 1]
        chart1!.children[7].scale = [1, 0.0667 * Float(0.8) * Float(product1.nutriments.carbohydrates) * 5 / 26, 1]
        chart1!.children[8].scale = [1, 0.1111 * Float(0.8) * Float(product1.nutriments.fat) * 5 / 7, 1]
        chart1!.children[9].scale = [1, 0.0714 * Float(0.8) * Float(product1.nutriments.sugars) * 5 / 9, 1]
        chart1!.children[10].scale = [1, 0.0476 * Float(0.8) * Float(product1.nutriments.cals) / 40, 1]
        
        //scale bars chart2
        chart2!.children[6].scale = [1, 0.0909 * Float(0.8) * Float(product2.nutriments.proteins), 1]
        chart2!.children[7].scale = [1, 0.0667 * Float(0.8) * Float(product2.nutriments.carbohydrates) * 5 / 26, 1]
        chart2!.children[8].scale = [1, 0.1111 * Float(0.8) * Float(product2.nutriments.fat) * 5 / 7, 1]
        chart2!.children[9].scale = [1, 0.0714 * Float(0.8) * Float(product2.nutriments.sugars) * 5 / 9, 1]
        chart2!.children[10].scale = [1, 0.0476 * Float(0.8) * Float(product2.nutriments.cals) / 40, 1]
        
        chart3!.children[6].scale = [1, 0.0909 * Float(0.8) * Float(50), 1]
        chart3!.children[7].scale = [1, 0.0667 * Float(0.8) * Float(260) * 5 / 26, 1]
        chart3!.children[8].scale = [1, 0.1111 * Float(0.8) * Float(70) * 5 / 7 , 1]
        chart3!.children[9].scale = [1, 0.0714 * Float(0.8) * Float(90) * 5 / 9, 1]
        chart3!.children[10].scale = [1, 0.0476 * Float(0.8) * Float(2000) / 40, 1]
        
        print("Floors: \(chart1!.children[0])")
        print("Text on bar: \(chart1!.children[1])")
        print("Bars: \(chart1!.children[6])")
        print("Tags: \(chart1!.children[11])")
        print("Plate element: \(anchor.plateElement)")
        print("Protein ball: \(proteinBig)")
        
        return arView
    }
    
    private static func setBarValues(chart: Entity, material: SimpleMaterial, nutriments: Nutriments) {
        let textEntity: Entity = chart.children[0].children[0]
        var textModelComp: ModelComponent = textEntity.components[ModelComponent]!
        textModelComp.materials[0] = material
        textModelComp.mesh = .generateText("\(nutriments.proteins)", extrusionDepth: 0.001, font: .systemFont(ofSize: 0.022), containerFrame: .zero, alignment: .left, lineBreakMode: .byCharWrapping)
        chart.children[1].children[0].children[0].components.set(textModelComp)
        
        textModelComp.mesh = .generateText("\(nutriments.carbohydrates)", extrusionDepth: 0.001, font: .systemFont(ofSize: 0.022), containerFrame: .zero, alignment: .left, lineBreakMode: .byCharWrapping)
        chart.children[2].children[0].children[0].components.set(textModelComp)
        
        textModelComp.mesh = .generateText("\(nutriments.fat)", extrusionDepth: 0.001, font: .systemFont(ofSize: 0.022), containerFrame: .zero, alignment: .left, lineBreakMode: .byCharWrapping)
        chart.children[3].children[0].children[0].components.set(textModelComp)
        
        textModelComp.mesh = .generateText("\(nutriments.sugars)", extrusionDepth: 0.001, font: .systemFont(ofSize: 0.022), containerFrame: .zero, alignment: .left, lineBreakMode: .byCharWrapping)
        chart.children[4].children[0].children[0].components.set(textModelComp)
        
        textModelComp.mesh = .generateText("\(nutriments.cals)", extrusionDepth: 0.001, font: .systemFont(ofSize: 0.022), containerFrame: .zero, alignment: .left, lineBreakMode: .byCharWrapping)
        chart.children[5].children[0].children[0].components.set(textModelComp)
    }
    
    private static func setTagsToChart(chart: Entity, material: SimpleMaterial) {
        var tag: Entity = chart.children[11].children[0].children[0]
        setTags(entity: &tag, material: material, text: "proteins")
        
        tag = chart.children[12].children[0].children[0]
        setTags(entity: &tag, material: material, text: "carbs")
        
        tag = chart.children[13].children[0].children[0]
        setTags(entity: &tag, material: material, text: "fats")
        
        tag = chart.children[14].children[0].children[0]
        setTags(entity: &tag, material: material, text: "sugars")
        
        tag = chart.children[15].children[0].children[0]
        setTags(entity: &tag, material: material, text: "cals")
    }
    
    private static func setTags(entity: inout Entity, material: SimpleMaterial, text: String) {
        entity.transform.translation = [-0.08, entity.transform.translation.y, entity.transform.translation.z]
        var tagModelComp: ModelComponent = entity.components[ModelComponent]!
        tagModelComp.materials[0] = material
        tagModelComp.mesh = .generateText(text, extrusionDepth: 0.001, font: .systemFont(ofSize: 0.022), containerFrame: .zero, alignment: .left, lineBreakMode: .byCharWrapping)
        entity.components.set(tagModelComp)
    }
    
    
    static func spawnNutrient(amount: Int, listB: inout [Entity?], listS: inout [Entity?], bigE: Entity, smallE: Entity, c: Coordinates, anchor: Experience.Box) {
        let big = amount / 4
        let small = amount % 4
        listB = createNutriEntities(typeOf: bigE, numberOf: big)
        listS = createNutriEntities(typeOf: smallE, numberOf: small)
        setPositionToEntities(list: listB, x: c.x, y: c.y, z: c.z, delta: 0.015)
        setPositionToEntities(list: listS, x: c.x, y: (c.y + 0.015 * Float(big)), z: c.z, delta: 0.015)
        addChildrenToAnchor(list: listB, anchor: anchor)
        addChildrenToAnchor(list: listS, anchor: anchor)
    }
    
    static func spawnCalories(amount: Int, listB: inout [Entity?], listM: inout [Entity?], listS: inout [Entity?], bigE: Entity, mediumE: Entity, smallE: Entity, c: Coordinates, anchor: Experience.Box) {
        let big = amount / 100
        let med = (amount % 100) / 10
        let small = amount % 10
        listB = createNutriEntities(typeOf: bigE, numberOf: big)
        listM = createNutriEntities(typeOf: mediumE, numberOf: med)
        listS = createNutriEntities(typeOf: smallE, numberOf: small)
        setPositionToEntities(list: listB, x: c.x, y: c.y, z: c.z, delta: 0.02)
        setPositionToEntities(list: listM, x: c.x, y: c.y, z: c.z, delta: 0.015)
        setPositionToEntities(list: listS, x: c.x, y: c.y, z: c.z, delta: 0.015)
        addChildrenToAnchor(list: listB, anchor: anchor)
        addChildrenToAnchor(list: listM, anchor: anchor)
        addChildrenToAnchor(list: listS, anchor: anchor)
    }
    
    static func createNutriEntities(typeOf entity: Entity?, numberOf n: Int) -> [Entity?] {
        var list = [Entity?]()
        for _ in 0..<n {
            let temp = entity!.clone(recursive: true)
            list.append(temp)
        }
        return list
    }
    
    static func setPositionToEntities(list: [Entity?], x: Float, y: Float, z: Float, delta: Float) {
        var deltaY: Float = y
        for i in 0..<list.count {
            let stream = i % 5
            switch stream {
            case 0:
                list[i]!.position = [x + delta, deltaY, z + delta]
            case 1:
                list[i]!.position = [x - delta, deltaY, z - delta]
            case 2:
                list[i]!.position = [x - delta, deltaY, z + delta]
            case 3:
                list[i]!.position = [x + delta, deltaY, z - delta]
            case 4:
                list[i]!.position = [x, deltaY, z]
            default:
                list[i]!.position = [x, y, z]
            }
            deltaY += delta
        }
    }
    
    static func addChildrenToAnchor(list: [Entity?], anchor: Experience.Box) {
        for entity in list {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                anchor.addChild(entity!)
            }
            
        }
    }
    
    func removeChildrenFromScene(list: [Entity?]) {
        for entity in list {
            entity!.removeFromParent()
        }
    }
}

struct Coordinates {
    var x: Float
    var y: Float
    var z: Float
}
