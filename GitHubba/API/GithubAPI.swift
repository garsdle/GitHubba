//
//  GithubAPI.swift
//  GitHubba
//
//  Created by Emmanuel Garsd on 5/21/18.
//  Copyright © 2018 garsd. All rights reserved.
//

import Foundation

//Used for all API results
enum Result<T> {
  case success(T)
  case failure(Error)
}

protocol GithubAPI {
  func authenticate(completed: @escaping (Result<Bool>) -> ())
  func getRepos(completed: (Result<[Repo]>) -> () )
}
