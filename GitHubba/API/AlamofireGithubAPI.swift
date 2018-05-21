//
//  AlamofireGithubAPI.swift
//  GitHubba
//
//  Created by Emmanuel Garsd on 5/21/18.
//  Copyright © 2018 garsd. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit
import SwiftyJSON

enum APIError: Error {
  case jsonParseFailed(String)
}

//Made a concious decision not to use https://github.com/nerdishbynature/octokit.swift
//Might use MOYA for a bigger project
class AlamofireGithubAPI: GithubAPI {
  private let baseURL: String
  private let authToken: String
  private let commonHeaders: HTTPHeaders

  init(baseURL: String, authToken: String) {
    self.baseURL = baseURL
    self.authToken = authToken
    commonHeaders = ["Authorization": "Token \(authToken)"]
  }
}

//Auth
extension AlamofireGithubAPI {
  func authenticate(completed: @escaping (Result<Bool>) -> ()) {
    Alamofire
      .request(baseURL, parameters: nil, headers: commonHeaders)
      .validate(statusCode: 200..<300)
      .validate(contentType: ["application/json"])
      .responseData()
      .done { _ in
        completed(Result.success(true))
      }
      .catch { error in
        completed(Result.failure(error))
      }
  }
}

//Repos
extension AlamofireGithubAPI {
  func getRepos(completed: @escaping (Result<[Repo]>) -> ()) {
    Alamofire
      .request(baseURL + "/user/repos", parameters: nil, headers: commonHeaders)
      .validate(statusCode: 200..<300)
      .validate(contentType: ["application/json"])
      .responseData()
      .map { result in
        let repos = try JSONDecoder().decode([Repo].self, from: result.data)
        return repos
      }
      .done { completed(Result.success($0)) }
      .catch { completed(Result.failure($0)) }
  }
  
}

//Pullrequests
extension AlamofireGithubAPI {
  //FIXME: Fully decouple networking from our bussiness model
  struct NetworkPullRequest: Codable {
    struct Base: Codable {
      let repo: Repo
    }
    let id: Int
    let title: String
    let user: User
    let base: Base
  }
  
  func getOpenPullRequests(fullRepoName: String, completed: @escaping (Result<[PullRequest]>) -> ()) {
    Alamofire
      .request(baseURL + "/repos/\(fullRepoName)/pulls", parameters: nil, headers: commonHeaders)
      .validate(statusCode: 200..<300)
      .validate(contentType: ["application/json"])
      .responseData()
      .map { result in
        let networkPullRequests = try JSONDecoder().decode([NetworkPullRequest].self, from: result.data)
        let pullRequests = networkPullRequests.map { (networkPullRequest: NetworkPullRequest) -> PullRequest in
          let pullRequest = PullRequest(id: networkPullRequest.id,
                                        title: networkPullRequest.title,
                                        repoId: networkPullRequest.base.repo.id,
                                        user: networkPullRequest.user)
          return pullRequest
        }
        return pullRequests
      }
      .done { completed(Result.success($0)) }
      .catch { completed(Result.failure($0)) }
  }
}
