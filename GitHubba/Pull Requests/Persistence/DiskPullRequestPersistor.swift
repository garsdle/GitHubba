//
//  DiskPullRequestPersistor.swift
//  GitHubba
//
//  Created by Emmanuel Garsd on 5/21/18.
//  Copyright © 2018 garsd. All rights reserved.
//

import Foundation
import Disk

class DiskPullRequestPersistor: PullRequestPersistor {
  func save(pullRequests: [PullRequest]) throws {
    try Disk.save(pullRequests, to: .documents, as: "PullRequests.json")
  }
  
  func getPullRequests(repoId: Int) throws -> [PullRequest] {
    let pullRequests = try Disk.retrieve("PullRequests.json", from: .documents, as: [PullRequest].self)
    //Filtering like this is not scalable and would be much better done in realm or core data
    return pullRequests.filter { $0.repoId == repoId }
  }
}
