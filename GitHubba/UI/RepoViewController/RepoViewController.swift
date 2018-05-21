//
//  RepoViewController.swift
//  GitHubba
//
//  Created by Emmanuel Garsd on 5/21/18.
//  Copyright © 2018 garsd. All rights reserved.
//

import UIKit
import Down

protocol RepoViewControllerDelegate: class {
  func selected(pullRequest: PullRequest)
}

class RepoViewController: UIViewController {
  weak var delegate: RepoViewControllerDelegate?
  
  @IBOutlet weak var textView: UITextView!
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint!
  
  private let repo: Repo
  private let pullRequestStore: PullRequestStore
  
  init(repo: Repo, pullRequestStore: PullRequestStore) {
    self.repo = repo
    self.pullRequestStore = pullRequestStore
    super.init(nibName: "RepoView", bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError("Not implemented") }
}


extension RepoViewController {
  override func viewDidLoad() {
    //FIXME: Make big repo names fit title
    title = repo.name
    
    //FIXME: Make a cell for Pull Requests don't use RepoCell
    tableView.register(UINib(nibName: "RepoCell", bundle: nil), forCellReuseIdentifier: "RepoCell")
    tableView.dataSource = self
    tableView.delegate = self
    pullRequestStore.delegate = self
    
    textView.isHidden = true
    pullRequestStore.githubAPI.getReadme(fullRepoName: repo.fullName) { [weak self] (result) in
      guard let `self` = self else { return }
      switch result {
      case .failure(let error):
        self.textView.text = "Unable to get readme for repo"
        print(error)
      case .success(let readmeText):
        guard let readmeText = readmeText else {
          self.textView.text = "No Readme Available"
          return
        }
        self.textView.attributedText = try? Down(markdownString: readmeText).toAttributedString()
        var halfFrame = self.view.frame.size
        halfFrame.height /= 2
        let fitSize = self.textView.sizeThatFits(halfFrame)
        UIView.animate(withDuration: 0.3, animations: {
          if fitSize.height < self.textView.frame.height {
            self.textViewHeightConstraint.constant = fitSize.height
          }
          self.textView.isHidden = false
        })
      }
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareButtonTapped))
  }
  
  @objc func shareButtonTapped(){
    let activityController = UIActivityViewController(activityItems: [repo.url], applicationActivities: nil)
    self.present(activityController, animated: true, completion: nil)
  }
}


//MARK: - Table View Protocols
extension RepoViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return pullRequestStore.pullRequests.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return tableView.dequeueReusableCell(withIdentifier: "RepoCell", for: indexPath)
  }
}

extension RepoViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let pullRequest = pullRequestStore.pullRequests[indexPath.row]
    cell.textLabel?.text = pullRequest.title
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let pullRequest = pullRequestStore.pullRequests[indexPath.row]
    delegate?.selected(pullRequest: pullRequest)
  }
}

extension RepoViewController: PullRequestStoreDelegate {
  func updated(pullRequests: [PullRequest]) {
    tableView.reloadData()
  }
}

