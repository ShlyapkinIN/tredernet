//
//  MainPresenter.swift
//  tredernet
//
//  Created by Shlyapkin Ivan on 20.10.2020.
//

/// Main screen's presenter
final class MainPresenter {

	/// Main screen's view
	weak var view: MainViewInput?

	/// Main router
	weak var router: MainRouter?

	/// Main screen's interactor
	var interactor: MainInteractorInput?
}

extension MainPresenter: MainViewOutput {
	func viewConfigured() {
		interactor?.configureConnection()
	}
}

extension MainPresenter: MainInteractorOutput {
	func addNewTicker(with model: TickerModel) {
		view?.addNewCell(with: StockViewModel(model: model))
	}

	func updateTicker(with model: TickerModel) {
		view?.updateCell(with: model)
	}

}
