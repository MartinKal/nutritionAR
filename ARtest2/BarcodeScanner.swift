//
//  BarcodeScanner.swift
//  ARtest2
//
//  Created by Martin Kalaydzhiev on 3/14/21.
//

import Foundation
import Vision
import UIKit

extension UIImage {
    func detectBarcodes(
        types symbologies: [VNBarcodeSymbology] = [.EAN8, .EAN13],
        completion: @escaping ([VNBarcodeObservation]?) ->()) {
        
        guard let image = self.cgImage else { return completion(nil) }
        let request = VNDetectBarcodesRequest()
        request.symbologies = symbologies
        
        DispatchQueue.global().async {
            let handler = VNImageRequestHandler(cgImage: image)
            
            try? handler.perform([request])
            guard let observations = request.results as? [VNBarcodeObservation] else {
                return completion(nil)
            }
            
            return completion(observations)
        }
    }
}
