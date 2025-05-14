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

        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)

        let listVC = ListViewController()
        let navController = UINavigationController(rootViewController: listVC)

        window.rootViewController = navController
        self.window = window

        window.makeKeyAndVisible()
    }
}
