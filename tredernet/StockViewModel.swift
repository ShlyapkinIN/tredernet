//
//  StockViewModel.swift
//  tredernet
//
//  Created by Shlyapkin Ivan on 18.10.2020.
//

struct StockViewModel {
	let tiker: String?

	var lastStockExchange: String?

	var closeSessionDiffProcentage: Double?

	var lastPrice: Double?

	var lastDealDiffPrice: Double? {
		didSet {
			isNeedAnimation = true
		}
	}

	var titleText: String { self.tiker ?? "" }

	var subtitleText: String {
		var finalSubTitle = ""

		if let lastStockExchange = self.lastStockExchange, !lastStockExchange.isEmpty {
			finalSubTitle.append("\(lastStockExchange)")
		}

		if let name = self.name, !name.isEmpty {
			if !finalSubTitle.isEmpty { finalSubTitle.append(" | ") }
			finalSubTitle.append("\(name)")
		}

		return finalSubTitle
	}

	var priceProcentageText: String {
		guard let closeSessionDiffProcentage = self.closeSessionDiffProcentage else { return "" }
		let procentage = Double((100 * closeSessionDiffProcentage).rounded(.up) / 100)
		return procentage > 0 ? "+\(procentage)%" : "\(procentage)%"
	}

	var lastPriceText: String {
		guard let lastPrice = self.lastPrice, let lastDealDiffPrice = self.lastDealDiffPrice else { return "" }
		let price = Double((100 * lastPrice).rounded(.up) / 100)
		let diffPrice = Double((100 * lastDealDiffPrice).rounded(.up) / 100)
		return "\(price) ( \(diffPrice) )"
	}

	var isMoreZero: Bool { (lastDealDiffPrice ?? 0) > 0 }

	var isNeedAnimation: Bool = false

	private let name: String?

	init(tiker: String? = nil, closeSessionDiffProcentage: Double? = nil, lastStockExchange: String? = nil, name: String? = nil,
		 lastPrice: Double? = nil, lastDealDiffPrice: Double? = nil, minStep: Double? = nil) {
		self.tiker = tiker
		self.name = name
		self.lastStockExchange = lastStockExchange
		self.lastPrice = lastPrice
		self.lastDealDiffPrice = lastDealDiffPrice
		self.closeSessionDiffProcentage = closeSessionDiffProcentage
	}
	
}
