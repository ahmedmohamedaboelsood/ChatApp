//
//  Defaults.swift
//  ChatApp
//
//  Created by 2B on 14/02/2024.
//

import Foundation

class Defaults{
    
    enum Keys :String {
        case userData = "userData"
    }
    
    static var userData : User? {
        set {
            let encoder = JSONEncoder()
            do{
                let data = try encoder.encode(newValue)
                UserDefaults.standard.set(data, forKey: Keys.userData.rawValue)
                UserDefaults.standard.synchronize()
            }catch{
                #if DEBUG
                print("Cannot save user obj")
                #endif
            }
        }
        
        get {
            if let data = UserDefaults.standard.data(forKey: Keys.userData.rawValue) {
                let decoder = JSONDecoder()
                do {
                    let user = try decoder.decode(User.self, from: data)
                    return user
                } catch {
                    #if DEBUG
                    print("Error decoding user object: \(error)")
                    #endif
                }
            }
            return nil
        }
    }
}
