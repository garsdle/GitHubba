//
//  Repo.swift
//  GitHubba
//
//  Created by Emmanuel Garsd on 5/21/18.
//  Copyright © 2018 garsd. All rights reserved.
//

import Foundation

//TODO: As this get's more complex map JSON using a separate class rather than use codable
struct Repo: Codable {
  let id: Int
  let name: String
  let url: URL
}
