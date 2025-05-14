//
//  SceneDelegate.swift
//  iOSChallenge
//
//  Created by Jacobo Adrián Sande Veiga on 14/5/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {

        // Safely unwrap UIWindowScene
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // Create the window using the windowScene
        let window = UIWindow(windowScene: windowScene)

        // Initialize your root view controller
        let listVC = ListViewController()
        let navController = UINavigationController(rootViewController: listVC)

        // Set the root view controller
        window.rootViewController = navController
        self.window = window

        // Make the window visible
        window.makeKeyAndVisible()
    }
}
