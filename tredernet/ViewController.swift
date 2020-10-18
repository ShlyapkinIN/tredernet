//
//  ViewController.swift
//  tredernet
//
//  Created by Shlyapkin Ivan on 18.10.2020.
//

import UIKit

class ViewController: UIViewController {

	/// Таблица со статьями
	private var tableView: UITableView = {
		let tableView = UITableView()
		tableView.estimatedRowHeight = 0
		tableView.backgroundColor = .white
		tableView.translatesAutoresizingMaskIntoConstraints = false
		return tableView
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white

		setupView()
		setupConstaraints()
	}

	private func setupView() {
		view.addSubview(tableView)
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

