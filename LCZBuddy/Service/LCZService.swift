//
//  LCZService.swift
//  LCZBuddy
//
//  Created by Andy Gandara on 4/13/20.
//  Copyright © 2020 Andy Gandara. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore
import FirebaseStorage

class LCZService {
    private let collection = Firestore.firestore().collection("lczs")
    private let storage = Storage.storage()
    private var lczs: [LCZ]?
    
    public func fetch(completion: @escaping ([LCZ]?) -> Void) {
        collection.getDocuments() { [weak self] (querySnapshot, error) in
            guard let self = self else { return }
            guard error == nil else {
                completion(nil)
                return
            }
                        
            let models: [LCZ]? = querySnapshot?.documents.compactMap { document in
                print(document.data())
                
                let result = Result { try document.data(as: LCZ.self) }
                switch result {
                case .success(let model): return model
                case .failure: return nil
                }
            }
            
            self.lczs = models ?? []
            completion(models)
        }
    }
    
    public func getLczs() -> [LCZ]? {
        return lczs
    }
    
    public func add(lcz: LCZ, images: [Data], completion: @escaping (Bool) -> Void) {
        do {
            // Add document to Firestore
            try collection.document(lcz.id).setData(from: lcz)
            
            // Add images to Storage
            let storageRef = storage.reference()
            images.enumerated().forEach { index, image in
                let imageRef = storageRef.child("lczImages/\(lcz.id)/\(index).png")
                let _ = imageRef.putData(image, metadata: nil) { (metadata, error) in
                    guard error == nil else {
                        print("Error uploading image to path \(imageRef.fullPath): \(String(describing: error))")
                        completion(false)
                        return
                    }
                }
            }
            completion(true)
            
            // Post notification
            NotificationCenter.default.post(name: Notification.Name("didAddLCZ"), object: nil)
        } catch let error {
            print("Error writing city to Firestore: \(error)")
            completion(false)
        }
    }
}

