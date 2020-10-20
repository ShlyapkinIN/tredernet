//
//  MainAssembly.swift
//  tredernet
//
//  Created by Shlyapkin Ivan on 20.10.2020.
//

/// Main assembler of screens
struct MainAssembly {

	/// Method assemble main screen
	/// - Returns: main screen view contoller
	static func makeMainScreen() -> MainViewController {
		let interactor = MainInteractor()

		let presenter = MainPresenter()
		presenter.interactor = interactor

		let viewController = MainViewController()
		viewController.presenter = presenter

		presenter.view = viewController
		interactor.presenter = presenter

		return viewController
	}
}
