//
//  AppDelegate.swift
//  GitHubba
//
//  Created by Emmanuel Garsd on 5/21/18.
//  Copyright © 2018 garsd. All rights reserved.
//
//
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var container: Container = Container()
  var window: UIWindow?
  var rootCoordinator: RootCoordinator?
  
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    //Debug
    if let root = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
      print("//////App Path////// \n", root)
    }
    let window = UIWindow(frame: UIScreen.main.bounds)
    self.window = window
    rootCoordinator = RootCoordinator(window: window, container: container)

    return true
  }
}

