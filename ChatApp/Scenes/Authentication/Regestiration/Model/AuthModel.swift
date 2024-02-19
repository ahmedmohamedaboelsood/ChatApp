//
//  AuthModel.swift
//  ChatApp
//
//  Created by 2B on 14/02/2024.
//

import Foundation
import FirebaseFirestoreSwift

struct User : Codable{
    var id = ""
    var email : String
    var password : String
    var pushId = ""
    var avatarLink : String
    var status : String
}
