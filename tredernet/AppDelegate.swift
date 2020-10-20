//
//  AppDelegate.swift
//  tredernet
//
//  Created by Shlyapkin Ivan on 18.10.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var router: MainRouter = MainRouter()

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		let view = MainAssembly.makeMainScreen()
		router.showMainScreen(with: view)
		
		return true
	}
}

