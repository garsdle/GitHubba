//
//  Repo.swift
//  GitHubba
//
//  Created by Emmanuel Garsd on 5/21/18.
//  Copyright © 2018 garsd. All rights reserved.
//

import Foundation

struct Repo {
  let id: UUID
  let name: String
  let url: URL
  let pullRequests: [String]
}
