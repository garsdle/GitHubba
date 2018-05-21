//
//  RepoStore.swift
//  GitHubba
//
//  Created by Emmanuel Garsd on 5/21/18.
//  Copyright © 2018 garsd. All rights reserved.
//

import Foundation

protocol RepoStoreDelegate: class {
  func updated(repos: [Repo])
}

//TODO: Make this a protocol so it can be stubbed for testing
class RepoStore {
  var repos: [Repo] = [Repo.init(id: UUID(), name: "Test1", url: Bundle.main.bundleURL, pullRequests: []), Repo.init(id: UUID(), name: "Test2", url: Bundle.main.bundleURL, pullRequests: [])]
  
//  private var repoAPI: RepoAPI
//  init(repoAPI: RepoAPI) {
//    self.repoAPI = repoAPI
//  }
}
