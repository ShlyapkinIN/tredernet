//
//  ViewController.swift
//  tredernet
//
//  Created by Shlyapkin Ivan on 18.10.2020.
//

import UIKit
import SocketIO

class ViewController: UIViewController {

	// интерактор
	let manager = SocketManager(socketURL: URL(string: "https://ws.tradernet.ru")!, config: [.log(true)])
	var tikerSet = Set<String>()

	// презентор
	var models: [StockViewModel] = []

	/// Таблица со статьями
	private lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.estimatedRowHeight = 65
		tableView.backgroundColor = .white
		tableView.delegate = self
		tableView.dataSource = self
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.tableFooterView = UIView()
		return tableView
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white

		setupView()
		setupConstaraints()

		let socket = manager.defaultSocket

		let tickersToWatchChanges = [ "RSTI", "GAZP", "MRKZ","RUAL","HYDR","MRKS","SBER","FEES","TGKA","VTBR","ANH.US","VICL.US","BURG. US","NBL.US","YETI.US","WSFS.US","NIO.US","DXC.US","MIC.US","HSBC.US","EXPN.EU","GSK.EU","SH P.EU","MAN.EU","DB1.EU","MUV2.EU","TATE.EU","KGF.EU","MGGT.EU","SGGD.EU" ]

		socket.on(clientEvent: .connect) {data, ack in
			print("socket connected")
			socket.emit("sup_updateSecurities2", tickersToWatchChanges);
		}

		socket.on("q") { [weak self] data, ack in
			guard let data = data.first, let jsonData = try? JSONSerialization.data(withJSONObject:data),
				  let parsedResult: Response = try? JSONDecoder().decode(Response.self, from: jsonData) else { return }
//			print(parsedResult)

			for tikerUpdate in parsedResult.q {
				guard let tiker = tikerUpdate.tiker, let self = self else { continue }
				if self.tikerSet.contains(tiker) {
					guard let index = self.models.firstIndex(where: { $0.tiker == tiker }) else { return }

					var currentModel = self.models[index]
					currentModel.lastPrice = tikerUpdate.lastPrice
					currentModel.lastDealDiffPrice = tikerUpdate.lastDealDiffPrice
					currentModel.lastStockExchange = tikerUpdate.lastStockExchange
					currentModel.closeSessionDiffProcentage = tikerUpdate.closeSessionDiffProcentage
					self.models[index] = currentModel

					self.tableView.beginUpdates()
					self.tableView.reloadRows(at: [IndexPath(row: index, section: 0) ], with: .none)
					self.tableView.endUpdates()
				} else {
					self.tikerSet.insert(tiker)
					self.models.append(StockViewModel(tiker: tikerUpdate.tiker,
													  closeSessionDiffProcentage: tikerUpdate.closeSessionDiffProcentage,
													  lastStockExchange: tikerUpdate.lastStockExchange,
													  name: tikerUpdate.name,
													  lastPrice: tikerUpdate.lastPrice,
													  lastDealDiffPrice: tikerUpdate.lastDealDiffPrice,
													  minStep: tikerUpdate.minStep))
					self.tableView.reloadData()
				}
			}
		}

		socket.connect()
	}

	private func setupView() {
		view.addSubview(tableView)
		tableView.register(StockCell.self, forCellReuseIdentifier: String(describing: StockCell.self))
	}

	private func setupConstaraints() {
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
		])
	}
}

extension ViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print(models[indexPath.row])
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		65
	}
}

extension ViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		models.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: StockCell.self), for: indexPath) as? StockCell
		cell?.setupCell(with: models[indexPath.row])
		return cell ?? UITableViewCell()
	}
}

