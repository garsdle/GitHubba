//
//  RootCoordinator.swift
//  GitHubba
//
//  Created by Emmanuel Garsd on 5/21/18.
//  Copyright © 2018 garsd. All rights reserved.
//

import UIKit

class RootCoordinator {
  let container: Container
  
  init(window: UIWindow, container: Container) {
    self.container = container
    
    let repoListVC = RepoListViewController(repoStore: container.repoStore)
    
    window.rootViewController = repoListVC
    window.makeKeyAndVisible()
  }
}
