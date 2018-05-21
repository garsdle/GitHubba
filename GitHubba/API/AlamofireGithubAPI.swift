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
