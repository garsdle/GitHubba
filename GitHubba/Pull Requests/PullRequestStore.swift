//
//  PullRequestStore.swift
//  GitHubba
//
//  Created by Emmanuel Garsd on 5/21/18.
//  Copyright © 2018 garsd. All rights reserved.
//

import Foundation

protocol PullRequestStoreDelegate: class {
  func updated(pullRequests: [PullRequest])
}

//FIXME: This store should be split into two
//It's acting as both the store for Pull requests and a convenience service for all things repo
class PullRequestStore {
  weak var delegate: PullRequestStoreDelegate?
  
  var pullRequests: [PullRequest] = [] {
    didSet {
      //TODO: Error persisting handling
      try? pullRequestPersistor.save(pullRequests: pullRequests)
      delegate?.updated(pullRequests: pullRequests)
    }
  }
  
  let githubAPI: GithubAPI
  private let repo: Repo
  private var pullRequestPersistor: PullRequestPersistor
  
  init(repo: Repo, githubAPI: GithubAPI, pullRequestPersistor: PullRequestPersistor) {
    self.repo = repo
    self.githubAPI = githubAPI
    self.pullRequestPersistor = pullRequestPersistor
    
    //Get the persisted repos if available
    do {
      pullRequests = try pullRequestPersistor.getPullRequests(repoId: repo.id)
    } catch {
      print(error)
      //TODO: Error handling
    }
    
    //As of now we just pull new requests immediately
    //TODO: Make this smarter
    fetchPullRequests()
  }
}

extension PullRequestStore {
  func fetchPullRequests() {
    githubAPI.getOpenPullRequests(fullRepoName: repo.fullName) { (result) in
      switch result {
      case .failure(let error):
        //TODO: Error handling
        print(error)
      case .success(let pullRequests):
        //TODO: This could be fancier and just save only changes
        self.pullRequests = pullRequests
      }
    }
  }
}
