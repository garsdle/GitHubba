//
//  DiskRepoPersistor.swift
//  GitHubba
//
//  Created by Emmanuel Garsd on 5/21/18.
//  Copyright © 2018 garsd. All rights reserved.
//

import Foundation
import Disk

//TODO: I would usually use Realm but in the interest of time I'm using Disk
//Because I have a protocol in between I can switch this easily down the road
class DiskRepoPersistor: RepoPersistor {
  func save(repos: [Repo]) throws {
    try Disk.save(repos, to: .documents, as: "Repos.json")
  }
  
  func getRepos() throws -> [Repo] {
    let repos = try Disk.retrieve("Repos.json", from: .documents, as: [Repo].self)
    return repos
  }
}
