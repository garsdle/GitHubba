//
//  RepoListViewController.swift
//  GitHubba
//
//  Created by Emmanuel Garsd on 5/21/18.
//  Copyright © 2018 garsd. All rights reserved.
//

import UIKit

class RepoListViewController: UIViewController {
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
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "RepoCell")
    tableView.dataSource = self
    tableView.delegate = self
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
}
