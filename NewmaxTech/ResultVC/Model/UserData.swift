//
//  UserData.swift
//  NewmaxTech
//
//  Created by Nodir on 09/12/20.
//

import Foundation


struct UserInfo: Codable {
    var login: String
    var id: Int
    var avatar_url: String
    var url: String
    
}


struct ArrayOfData: Codable {
    var name: String
    var description: String?
    var stargazers_count: Int
    var watchers_count: Int
    var forks_count: Int
    var owner: UserInfo
    

}
