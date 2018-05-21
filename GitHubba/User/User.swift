//
//  User.swift
//  GitHubba
//
//  Created by Emmanuel Garsd on 5/21/18.
//  Copyright © 2018 garsd. All rights reserved.
//

import Foundation

struct User: Codable {
  let id: Int
  let login: String
  let avatarURL: URL?
  
  enum CodingKeys: String, CodingKey {
    case id, login
    case avatarURL = "avatar_url"
  }
}
