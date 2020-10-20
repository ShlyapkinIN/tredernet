//
//  MainInteractor.swift
//  tredernet
//
//  Created by Shlyapkin Ivan on 20.10.2020.
//

import SocketIO

final class MainInteractor {
	weak var presenter: MainInteractorOutput?
	private let manager = SocketManager(socketURL: URL(string: "https://ws.tradernet.ru")!, config: [.log(true)])
	private var tickerSet = Set<String>()
}

extension MainInteractor: MainInteractorInput {
	func configureConnection() {
		let socket = manager.defaultSocket

		socket.on(clientEvent: .connect) { data, ack in
			let tickersToWatchChanges = [ "RSTI", "GAZP", "MRKZ","RUAL","HYDR","MRKS","SBER","FEES","TGKA",
										  "VTBR","ANH.US","VICL.US","BURG.US","NBL.US","YETI.US","WSFS.US",
										  "NIO.US","DXC.US","MIC.US","HSBC.US","EXPN.EU","GSK.EU","SHP.EU",
										  "MAN.EU","DB1.EU","MUV2.EU","TATE.EU","KGF.EU","MGGT.EU","SGGD.EU" ]
			socket.emit("sup_updateSecurities2", tickersToWatchChanges);
		}

		socket.on("q") { [weak self] data, ack in
			guard let data = data.first, let jsonData = try? JSONSerialization.data(withJSONObject:data),
				  let parsedResult: Response = try? JSONDecoder().decode(Response.self, from: jsonData) else { return }

			for tickerUpdate in parsedResult.q {
				guard let ticker = tickerUpdate.ticker, let self = self else { continue }
				if self.tickerSet.contains(ticker) {
					self.presenter?.updateTicker(with: tickerUpdate)
				} else {
					self.tickerSet.insert(ticker)
					self.presenter?.addNewTicker(with: tickerUpdate)
				}
			}
		}

		socket.connect()
	}
}
