//
//  StockViewModel.swift
//  tredernet
//
//  Created by Shlyapkin Ivan on 18.10.2020.
//

import UIKit

struct StockViewModel {
	let tiker: String?
	var lastStockExchange: String?
	let name: String?

	var closeSessionDiffProcentage: Double? {
		didSet {
			guard let closeSessionDiffProcentage = self.closeSessionDiffProcentage else { return }
			self.closeSessionDiffProcentage = Double(round(100 * closeSessionDiffProcentage) / 100)
		}
	}

	var lastPrice: Double? {
		didSet {
			guard let lastPrice = self.lastPrice else { return }
			self.lastPrice = Double(round(100 * lastPrice) / 100)
		}
	}

	var lastDealDiffPrice: Double?  {
		didSet {
			guard let lastDealDiffPrice = self.lastDealDiffPrice else { return }
			self.lastDealDiffPrice = Double(round(100 * lastDealDiffPrice) / 100)
		}
	}

	init(tiker: String? = nil, closeSessionDiffProcentage: Double? = nil, lastStockExchange: String? = nil, name: String? = nil,
		 lastPrice: Double? = nil, lastDealDiffPrice: Double? = nil, minStep: Double? = nil) {
		self.tiker = tiker
		self.name = name
		self.lastStockExchange = lastStockExchange

		if let lastPrice = lastPrice {
			self.lastPrice = Double(round(100 * lastPrice) / 100)
		}

		if let lastDealDiffPrice = lastDealDiffPrice {
			self.lastDealDiffPrice = Double(round(100 * lastDealDiffPrice) / 100)
		}


		if let closeSessionDiffProcentage = closeSessionDiffProcentage {
			self.closeSessionDiffProcentage = Double(round(100 * closeSessionDiffProcentage) / 100)
		}
	}
}
