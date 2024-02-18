//
//  SceneDelegate.swift
//  ChatApp
//
//  Created by Ahmed Abo Elsood on 30/01/2024.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var authListner : AuthStateDidChangeListenerHandle?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        autoLogin(scene: scene)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }

    private func setupAppRootViewController(scene:UIScene , vc : UIViewController){
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController(rootViewController: vc)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    private func autoLogin(scene:UIScene){
        
        if Reachability.isConnectedToNetwork() {
            authListner = Auth.auth().addStateDidChangeListener({ auth, user in
                Auth.auth().removeStateDidChangeListener(self.authListner!)
                if user != nil && (Defaults.userData != nil) {
                    print("there is user \(user?.email)")
                    self.setupAppRootViewController(scene: scene, vc: BaseTabBar())
                }else{
                    print("there is no user")
                    self.setupAppRootViewController(scene: scene, vc: LoginAndRegisterVC())
                }
            })
        }else{
            print("Connection fail")
            self.setupAppRootViewController(scene: scene, vc: LoginAndRegisterVC())
        }
    }
}

