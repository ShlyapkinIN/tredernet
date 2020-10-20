//
//  Response.swift
//  tredernet
//
//  Created by Shlyapkin Ivan on 18.10.2020.
//

struct TickerModel: Decodable {
	let ticker: String?
	var closeSessionDiffProcentage: Double?
	var lastStockExchange: String?
	let name: String?
	var lastPrice: Double?
	var lastDealDiffPrice: Double?
	let minStep: Double?

	enum CodingKeys: String, CodingKey {
		case ticker = "c"
		case closeSessionDiffProcentage = "pcp"
		case lastStockExchange = "ltr"
		case name
		case lastPrice = "ltp"
		case lastDealDiffPrice = "chg"
		case minStep = "min_step"
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		self.ticker = try? container.decode(String?.self, forKey: .ticker)
		self.closeSessionDiffProcentage = try? container.decode(Double?.self, forKey: .closeSessionDiffProcentage)
		self.lastStockExchange = try? container.decode(String?.self, forKey: .lastStockExchange)
		self.name = try? container.decode(String?.self, forKey: .name)
		self.lastPrice = try? container.decode(Double?.self, forKey: .lastPrice)
		self.lastDealDiffPrice = try? container.decode(Double?.self, forKey: .lastDealDiffPrice)
		self.minStep = try? container.decode(Double?.self, forKey: .minStep)
	}
}
