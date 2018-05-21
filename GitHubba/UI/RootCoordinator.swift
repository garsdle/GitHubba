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
  let navigationController: UINavigationController
  
  init(window: UIWindow, container: Container) {
    self.container = container
    
    navigationController = UINavigationController()
    let repoListVC = RepoListViewController(repoStore: container.repoStore)
    navigationController.viewControllers = [repoListVC]
    
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
  }
}
