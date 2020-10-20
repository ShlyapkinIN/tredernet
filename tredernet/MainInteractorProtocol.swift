//
//  MainInteractorProtocol.swift
//  tredernet
//
//  Created by Shlyapkin Ivan on 20.10.2020.
//

protocol MainInteractorInput {
	/// Method congurates connection by socket
	func configureConnection()
}

protocol MainInteractorOutput: class {
	/// Method signals that received new ticker
	/// - Parameter model: ticker's model
	func addNewTicker(with model: TickerModel)

	/// Method signals that received update of ticker
	/// - Parameter model: ticker's model
	func updateTicker(with model: TickerModel)
}
