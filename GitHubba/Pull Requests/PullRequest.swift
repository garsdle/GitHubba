//
//  PullRequest.swift
//  GitHubba
//
//  Created by Emmanuel Garsd on 5/21/18.
//  Copyright © 2018 garsd. All rights reserved.
//

import Foundation

struct PullRequest: Codable {
  let id: Int
  let title: String
  let repoId: Int
  let user: User
}
