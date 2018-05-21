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
    repoListVC.delegate = self
    navigationController.viewControllers = [repoListVC]
    
    window.rootViewController = navigationController
    window.makeKeyAndVisible()
  }
}


extension RootCoordinator: RepoListViewControllerDelegate {
  func selected(repo: Repo) {
    let pullRequestStore = container.make(repo: repo)
    let repoVC = RepoViewController(repo: repo, pullRequestStore: pullRequestStore)
    repoVC.delegate = self
    navigationController.pushViewController(repoVC, animated: true)
  }
}

extension RootCoordinator: RepoViewControllerDelegate {
  func selected(pullRequest: PullRequest) {
    let pullrequestVC = PullRequestViewController(pullRequest: pullRequest)
    navigationController.pushViewController(pullrequestVC, animated: true)
  }
}
