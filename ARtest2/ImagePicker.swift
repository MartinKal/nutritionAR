//
//  ImagePicker.swift
//  ARtest2
//
//  Created by Martin Kalaydzhiev on 3/15/21.
//
import UIKit
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage
    @Environment(\.presentationMode) private var presentationMode
    @State private var barcode = ""
    @Binding var products: [Product]
    
    var sourceType: UIImagePickerController.SourceType = .camera
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                //parent.selectedImage = image
                image.detectBarcodes { barcodes in
                    guard let b = barcodes?.first else {
                        self.parent.barcode = ""
                        return
                    }
                    DispatchQueue.main.async {
                        self.parent.barcode = b.payloadStringValue ?? ""
                        self.parent.loadData { p in
                            if !self.parent.products.contains(p) {
                                self.parent.products.append(p)
                            }
                        }
                    }
                }
            }
            parent.presentationMode.wrappedValue.dismiss()

        }
    }
    func loadData(completion: @escaping (Product) -> ()) {
        let s = "https://world.openfoodfacts.org/api/v0/product/" + barcode + ".json"
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
                        let product1 = res.product!
                        completion(product1)
                    }
                } else {
                    print("No info for this product")
                }
            }
        }
        task.resume()
    }
}

