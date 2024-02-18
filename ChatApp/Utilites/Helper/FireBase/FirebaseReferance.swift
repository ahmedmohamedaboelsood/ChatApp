//
//  FirebaseReferance.swift
//  ChatApp
//
//  Created by 2B on 14/02/2024.
//

import Foundation
import Firebase

enum FIBCollections : String{
    case user = "User"
}

class FIBReferance {
    static func firebaseReferance(_ collectionName : FIBCollections ) -> CollectionReference {
        return Firestore.firestore().collection(collectionName.rawValue)
    }
}
