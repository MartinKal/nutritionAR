//
//  ARGameView.swift
//  ARtest2
//
//  Created by Martin Kalaydzhiev on 3/21/21.
//

import SwiftUI
import UIKit
import RealityKit

struct ARGameView: View {
    var body: some View {
        ARGameContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARGameContainer: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .null)
        let anchor = try! Experience.loadBox2()
        arView.scene.anchors.append(anchor)
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
    
}

struct ARGameView_Previews: PreviewProvider {
    static var previews: some View {
        ARGameView()
    }
}
