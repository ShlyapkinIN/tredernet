//
//  MainViewProtocol.swift
//  tredernet
//
//  Created by Shlyapkin Ivan on 20.10.2020.
//

protocol MainViewInput: class {

	/// Method adds new cell to tableView
	/// - Parameter viewModel: view model of new cell
	func addNewCell(with viewModel: StockViewModel)

	/// Method update cell
	/// - Parameter model: model of update
	func updateCell(with model: TickerModel)
}

protocol MainViewOutput {

	/// Method signals that view ready to update
	func viewConfigured()
}
