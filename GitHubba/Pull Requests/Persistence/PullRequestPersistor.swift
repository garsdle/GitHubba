//
//  PullRequestPersistence.swift
//  GitHubba
//
//  Created by Emmanuel Garsd on 5/21/18.
//  Copyright © 2018 garsd. All rights reserved.
//

import Foundation

protocol PullRequestPersistor {
  func save(pullRequests: [PullRequest]) throws
  func getPullRequests(repoId: Int) throws -> [PullRequest]
}
