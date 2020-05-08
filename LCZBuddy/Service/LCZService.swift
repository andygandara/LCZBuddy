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
import UIKit

class LCZService {
    private let collection = Firestore.firestore().collection("lczs")
    private let storage = Storage.storage()
    private var lczs: [LCZ]?
    private var images: [UIImage]?
    
    public func fetchLCZs(completion: @escaping ([LCZ]?) -> Void) {
        collection.getDocuments() { [weak self] (querySnapshot, error) in
            guard let self = self else { return }
            guard error == nil else {
                completion(nil)
                return
            }
                        
            let models: [LCZ]? = querySnapshot?.documents.compactMap { document in
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
    
    public func fetchImages(id: String, completion: @escaping ([UIImage]?) -> Void) {
        var images: [UIImage] = []
        
        let group = DispatchGroup()
        let storageReference = storage.reference().child("lczImages/\(id)")
        storageReference.listAll { (result, error) in
            if error != nil {
                completion(nil)
                return
            }
            
            for item in result.items {
                group.enter()
                item.getData(maxSize: 24 * 1024 * 1024) { data, error in
                    if error != nil {
                        completion(nil)
                        return
                    } else {
                        guard let data = data, let image = UIImage(data: data) else {
                            completion(nil)
                            return
                        }
                        images.append(image)
                        group.leave()
                    }
                }
            }
            
            group.notify(queue: DispatchQueue.main) {
                completion(images)
            }
        }
    }
    
    public func add(lcz: LCZ, images: [Data], completion: @escaping (Bool) -> Void) {
        do {
            // Add document to Firestore
            try collection.document(lcz.id).setData(from: lcz)
            
            // Add images to Storage
            let storageRef = storage.reference()
            images.enumerated().forEach { index, image in
                let imageRef = storageRef.child("lczImages/\(lcz.id)/\(index).jpg")
                let _ = imageRef.putData(image, metadata: nil) { (metadata, error) in
                    guard error == nil else {
                        completion(false)
                        return
                    }
                }
            }
            completion(true)
            
            // Post notification
            NotificationCenter.default.post(name: Notification.Name("didAddLCZ"), object: nil)
        } catch {
            completion(false)
        }
    }
}

