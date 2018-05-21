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
  weak var delegate: RepoStoreDelegate? {
    didSet {
      //Send the initial repos on delegate signup
      delegate?.updated(repos: repos)
    }
  }
  
  var repos: [Repo] = [Repo.init(id: 1, name: "Test1", url: Bundle.main.bundleURL), Repo.init(id: 2, name: "Test2", url: Bundle.main.bundleURL)] {
    didSet {
      delegate?.updated(repos: repos)
    }
  }
  
  private var githubAPI: GithubAPI
  
  init(githubAPI: GithubAPI) {
    self.githubAPI = githubAPI
    //Right now we just get the latest repos on init
    fetchRepos()
  }
}

extension RepoStore {
  func fetchRepos() {
    //Check if there are new repos available
    githubAPI.getRepos { (result) in
      switch result {
      case .failure(let error):
        //TODO: Add UI error notification
        print(error)
      case .success(let repos):
        self.repos = repos
      }
    }
  }
}
