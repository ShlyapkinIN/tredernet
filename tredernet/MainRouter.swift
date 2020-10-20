//
//  MainRouter.swift
//  tredernet
//
//  Created by Shlyapkin Ivan on 20.10.2020.
//

import UIKit

final class MainRouter {

	var window: UIWindow?

	func showMainScreen(with controller: MainViewController) {
		self.window = UIWindow(frame: UIScreen.main.bounds)
		self.window?.rootViewController = controller
		self.window?.makeKeyAndVisible()
	}
}
