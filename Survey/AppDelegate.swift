//
//  AppDelegate.swift
//  Survey
//
//  Created by Palvi on 20/06/20.
//  Copyright © 2020 Palvi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        // Override point for customization after application launch.
        setupUniversalNavigationBarColor()
        
        return true
    }
    
    func setupUniversalNavigationBarColor()
    {
        //To change Navigation Bar Background Color
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.07450980392, green: 0.1019607843, blue: 0.1843137255, alpha: 1)
        
        //To change Navigation Item Color
        UINavigationBar.appearance().tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        //To change Navigation transparency
        UINavigationBar.appearance().isTranslucent = false
        
        //To change Navigation Bar Title Color
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

