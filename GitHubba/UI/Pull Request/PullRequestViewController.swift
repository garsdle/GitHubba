//
//  PullRequestViewController.swift
//  GitHubba
//
//  Created by Emmanuel Garsd on 5/21/18.
//  Copyright © 2018 garsd. All rights reserved.
//

import UIKit
import AlamofireImage
class PullRequestViewController: UIViewController {
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var avaterImageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  
  private let pullRequest: PullRequest

  init(pullRequest: PullRequest) {
    self.pullRequest = pullRequest
    super.init(nibName: "PullRequestView", bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError("Not implemented") }
}

extension PullRequestViewController {
  override func viewDidLoad() {
    titleLabel.text = pullRequest.title
    authorLabel.text = pullRequest.user.login
    let formatter = DateFormatter()
    formatter.dateFormat = "MM-dd-yyyy HH:mm"
    dateLabel.text = formatter.string(from: pullRequest.createdAt)
    
    if let avatarURL = pullRequest.user.avatarURL {
      avaterImageView.af_setImage(withURL: avatarURL, placeholderImage: nil, filter: nil, progress: nil, progressQueue: DispatchQueue.main, imageTransition: .crossDissolve(0.3), runImageTransitionIfCached: true) { (response) in
      }
      avaterImageView.layer.cornerRadius = avaterImageView.frame.width / 2
      avaterImageView.clipsToBounds = true
    } else {
      avaterImageView.isHidden = true
    }
    
  }
}
