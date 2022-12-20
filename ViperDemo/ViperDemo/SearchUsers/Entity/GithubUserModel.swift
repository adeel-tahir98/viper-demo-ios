//
//  GithubUserModel.swift
//  ViperDemo
//
//  Created by Adeel Tahir on 12/17/22.
//

import Foundation

struct GithubUser: Codable, Hashable {
    let avatarURL, login, reposURL, followersURL: String
    
    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case login
        case reposURL = "repos_url"
        case followersURL = "followers_url"
    }
}

struct GithubUserList: Codable {
    let totalCount: Float
    let items: [GithubUser]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}
