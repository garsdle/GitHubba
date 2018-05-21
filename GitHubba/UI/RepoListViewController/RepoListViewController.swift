//
//  RepoListViewController.swift
//  GitHubba
//
//  Created by Emmanuel Garsd on 5/21/18.
//  Copyright © 2018 garsd. All rights reserved.
//

import UIKit

protocol RepoListViewControllerDelegate: class {
  func selected(repo: Repo)
}

class RepoListViewController: UIViewController {
  weak var delegate: RepoListViewControllerDelegate?
  
  @IBOutlet weak var tableView: UITableView!
  
  let repoStore: RepoStore
  
  init(repoStore: RepoStore) {
    self.repoStore = repoStore
    super.init(nibName: "RepoListView", bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) { fatalError("Not implemented") }
}

extension RepoListViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Repos"
    tableView.register(UINib(nibName: "RepoCell", bundle: nil), forCellReuseIdentifier: "RepoCell")
    tableView.dataSource = self
    tableView.delegate = self
    repoStore.delegate = self
  }
}


//MARK: RepoStore
extension RepoListViewController: RepoStoreDelegate {
  func updated(repos: [Repo]) {
    //FIXME: don't reload all the table view cells if they are all the same exact repos
    tableView.reloadData()
  }
}



//MARK: - Table View Protocols
extension RepoListViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return repoStore.repos.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return tableView.dequeueReusableCell(withIdentifier: "RepoCell", for: indexPath)
  }
}

extension RepoListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let repo = repoStore.repos[indexPath.row]
    cell.textLabel?.text = repo.name
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let repo = repoStore.repos[indexPath.row]
    delegate?.selected(repo: repo)
  }
}
