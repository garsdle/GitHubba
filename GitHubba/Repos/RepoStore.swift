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
  
  var repos: [Repo] = [] {
    didSet {
      delegate?.updated(repos: repos)
    }
  }
  
  private var githubAPI: GithubAPI
  private var repoPersistor: RepoPersistor

  init(githubAPI: GithubAPI, repoPersistor: RepoPersistor) {
    self.githubAPI = githubAPI
    self.repoPersistor = repoPersistor
    
    //Get the persisted repos if available
    do {
      repos = try repoPersistor.getRepos()
    } catch {
      //TODO: Error handling
    }
    
    //Right now we just get the latest repos on init
    //TODO: Add reachability and fetch when online or on a UI Request
    fetchRepos()
  }
}

extension RepoStore {
  func fetchRepos() {
    //Check if there are new repos available
    githubAPI.getRepos { (result) in
      switch result {
      case .failure(let error):
        //TODO: Error handling
        print(error)
      case .success(let repos):
        //TODO: This could be fancier and not just save all the repos but only changes
        self.repos = repos
      }
    }
  }
}
