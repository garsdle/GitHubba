//
//  PullRequestViewController.swift
//  GitHubba
//
//  Created by Emmanuel Garsd on 5/21/18.
//  Copyright © 2018 garsd. All rights reserved.
//

import UIKit

class PullRequestViewController: UIViewController {
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  
  private let pullRequest: PullRequest
  
  init(pullRequest: PullRequest) {
    self.pullRequest = pullRequest
    super.init(nibName: "PullRequestView", bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError("Not implemented") }
}

extension PullRequestViewController {
  override func viewDidLoad() {
    title = pullRequest.title
    
  }
}
