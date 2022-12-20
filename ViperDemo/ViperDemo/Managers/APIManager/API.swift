//
//  API.swift
//  ViperDemo
//
//  Created by Adeel Tahir on 12/17/22.
//

import Foundation

struct API {
    static let kSearchUsers = "https://api.github.com/search/users?q={username}+in:login&type=Users&per_page={maxItems}&page={pageNumber}"
    static let kUserDetails = "https://api.github.com/users/{username}"
    static let kUserReposAPI = "https://api.github.com/users/{username}/repos"
    static let kUserFollowersAPI = "https://api.github.com/users/{username}/followers"
}
