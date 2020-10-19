//
//  AppDelegate.swift
//  tredernet
//
//  Created by Shlyapkin Ivan on 18.10.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		let initialViewControlleripad : UIViewController = MainViewController()
		self.window = UIWindow(frame: UIScreen.main.bounds)
		self.window?.rootViewController = initialViewControlleripad
		self.window?.makeKeyAndVisible()
		
		return true
	}
}

