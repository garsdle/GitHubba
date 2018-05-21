//
//  RepoPersistor.swift
//  GitHubba
//
//  Created by Emmanuel Garsd on 5/21/18.
//  Copyright © 2018 garsd. All rights reserved.
//

import Foundation

protocol RepoPersistor {
  func save(repos: [Repo]) throws
  func getRepos() throws -> [Repo]
}
