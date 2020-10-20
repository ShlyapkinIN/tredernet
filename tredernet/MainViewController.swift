//
//  ViewController.swift
//  tredernet
//
//  Created by Shlyapkin Ivan on 18.10.2020.
//

import UIKit

class MainViewController: UIViewController {

	var presenter: MainViewOutput?
	private var models: [StockViewModel] = []

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
		
		presenter?.viewConfigured()
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

extension MainViewController: MainViewInput {
	func updateCell(with model: TickerModel) {
		guard let index = models.firstIndex(where: { $0.titleText == model.ticker }) else { return }

		var currentModel = models[index]
		currentModel.isNeedAnimation = currentModel.lastDealDiffPrice != model.lastDealDiffPrice
		currentModel.lastPrice = model.lastPrice
		currentModel.lastDealDiffPrice = model.lastDealDiffPrice
		currentModel.lastStockExchange = model.lastStockExchange
		currentModel.closeSessionDiffProcentage = model.closeSessionDiffProcentage
		
		if models.count <= index {
			models[index] = currentModel
		}

		tableView.performBatchUpdates({ () -> Void in
			self.tableView.beginUpdates()
			self.tableView.reloadRows(at: [IndexPath(row: index, section: 0) ], with: .none)
			self.tableView.endUpdates()
		}, completion: { (finished) -> Void in
			self.models[index].isNeedAnimation = false
		})
	}

	func addNewCell(with viewModel: StockViewModel) {
		self.models.append(viewModel)
		self.tableView.reloadData()
	}
}

extension MainViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { 65 }
}

extension MainViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { models.count }

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: StockCell.self), for: indexPath) as? StockCell
		cell?.setupCell(with: models[indexPath.row])
		return cell ?? UITableViewCell()
	}
}

