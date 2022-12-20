//
//  UserDetailsModel.swift
//  ViperDemo
//
//  Created by Adeel Tahir on 18/12/2022.
//

import Foundation

struct UserDetailsModel: Codable, Hashable {
    let avatarURL: String
    let login, name, email, location, bio, company, blog: String?
    let reposCount, followersCount: Int
    let hireable: Bool?
    
    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case login
        case name
        case location
        case bio
        case blog
        case company
        case email
        case followersCount = "followers"
        case reposCount = "public_repos"
        case hireable
    }
}

struct UserRepository: Codable {
    let name: String
    let fullName: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case fullName = "full_name"
    }
}

struct UserFollower: Codable {
    let avatarURL, login: String
    let type: String?
    
    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case login
        case type
    }
}
