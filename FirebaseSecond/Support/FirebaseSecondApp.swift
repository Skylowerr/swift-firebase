//
//  FirebaseSecondApp.swift
//  FirebaseSecond
//
//  Created by Emirhan Gökçe on 22.02.2026.
//

import SwiftUI
import FirebaseCore

@main
struct FirebaseSecondApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}
