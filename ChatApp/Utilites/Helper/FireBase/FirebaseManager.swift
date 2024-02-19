//
//  FirebaseManager.swift
//  ChatApp
//
//  Created by 2B on 14/02/2024.
//

import Foundation
import Firebase

final class FIBManger{
    
    static let shared = FIBManger()
    
    private init(){}
    
    func registerUser(email: String , password : String , completion : @escaping (String) -> Void){
        if !Reachability.isConnectedToNetwork(){
            completion("Check your internet connection")
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error == nil {
                authResult?.user.sendEmailVerification(completion: { error in
                    if let error = error {
                        completion(error.localizedDescription)
                    }else{
                        completion("done")
                    }
                })
            }else{
                completion(error!.localizedDescription)
            }
            if let authResult = authResult?.user{
                let user = User(id: authResult.uid, email: email, password: password, pushId: "", avatarLink: "", status: "I'm busy now")
                self.saveUserToFirestore(user) { error in
                    completion(error)
                }
            }
        }
    }
    
    func loginUser(email: String , password : String , completion : @escaping (_ error:String? , _ isEmailVerified:Bool?) -> Void){
        if !Reachability.isConnectedToNetwork(){
            completion("Check your internet connection", nil)
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { authResults, error in
            if error == nil && authResults!.user.isEmailVerified {
                completion(error?.localizedDescription,true)
                self.downloadUserFromFireStore(userID: authResults!.user.uid) { error in
                    completion(error,true)
                }
            }else{
                completion(error?.localizedDescription,false)
            }
        }
    }
    
    func resendEmail(email:String,complition:@escaping(String?)->Void){
        Auth.auth().currentUser?.reload(completion: { error in
            Auth.auth().currentUser?.sendEmailVerification(completion: { error in
                complition(error?.localizedDescription)
            })
        })
    }
    
    func resetPassword( email : String , complation: @escaping(String?)->Void){
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            complation(error?.localizedDescription)
        }
    }
    
    private func downloadUserFromFireStore(userID:String, complation:@escaping (String)->Void){
        FIBReferance.firebaseReferance(.user).document(userID).getDocument { userDocument, error in
            
            guard let userDocument = userDocument else {
                complation("No data")
                return
            }
            let results = Result {
                try? userDocument.data(as: User.self)
            }
            switch results {
            case .success(let user):
                if let user = user {
                    Defaults.userData = user
                }
            case .failure(let error):
                complation(error.localizedDescription)
            }
        }
    }
    
    private func saveUserToFirestore(_ user : User , completion:@escaping(String)->Void){
        do {
            try FIBReferance.firebaseReferance(.user).document(user.id).setData(from: user)
            Defaults.userData = user
        }catch{
            completion(error.localizedDescription)
        }
    }
}
