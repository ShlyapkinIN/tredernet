//
//  StockCell.swift
//  tredernet
//
//  Created by Shlyapkin Ivan on 18.10.2020.
//

import UIKit
import Kingfisher

final class StockCell: UITableViewCell {

	private var tikerImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

	private var tikerLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 20)
		label.textColor = .black
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	private var tikerSubLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 12)
		label.textColor = .gray
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	private var closeSessionDiffProcentageLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 20)
		label.textColor = .black
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	private var diffProcentageContainerView: UIView = {
		let view = UIView()
		view.layer.cornerRadius = 8
		view.backgroundColor = .red
		view.translatesAutoresizingMaskIntoConstraints = false
		return view
	}()

	private var lastPriceLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 14)
		label.textColor = .black
		label.translatesAutoresizingMaskIntoConstraints = false
		label.setContentCompressionResistancePriority(.required, for: .horizontal)
		label.textAlignment = .right
		return label
	}()

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		accessoryType = .disclosureIndicator
		setup()
	}

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	private func setup() {
		contentView.addSubview(tikerImageView)
		contentView.addSubview(tikerLabel)
		contentView.addSubview(tikerSubLabel)
		contentView.addSubview(diffProcentageContainerView)
		contentView.addSubview(closeSessionDiffProcentageLabel)
		contentView.addSubview(lastPriceLabel)

		NSLayoutConstraint.activate([
			tikerImageView.heightAnchor.constraint(equalToConstant: 16),
			tikerImageView.widthAnchor.constraint(equalToConstant: 16),
			tikerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			tikerImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),

			tikerLabel.centerYAnchor.constraint(equalTo: tikerImageView.centerYAnchor),
			tikerLabel.leadingAnchor.constraint(equalTo: tikerImageView.trailingAnchor, constant: 10),

			tikerSubLabel.leadingAnchor.constraint(equalTo: tikerImageView.leadingAnchor),
			tikerSubLabel.trailingAnchor.constraint(equalTo: lastPriceLabel.leadingAnchor),
			tikerSubLabel.topAnchor.constraint(equalTo: tikerImageView.bottomAnchor, constant: 10),
			tikerSubLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),

			closeSessionDiffProcentageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			closeSessionDiffProcentageLabel.centerYAnchor.constraint(equalTo: tikerImageView.centerYAnchor),

			diffProcentageContainerView.trailingAnchor.constraint(equalTo: closeSessionDiffProcentageLabel.trailingAnchor, constant: 3),
			diffProcentageContainerView.centerYAnchor.constraint(equalTo: closeSessionDiffProcentageLabel.centerYAnchor),
			diffProcentageContainerView.bottomAnchor.constraint(equalTo: closeSessionDiffProcentageLabel.bottomAnchor, constant: 3),
			diffProcentageContainerView.centerXAnchor.constraint(equalTo: closeSessionDiffProcentageLabel.centerXAnchor),

			lastPriceLabel.trailingAnchor.constraint(equalTo: closeSessionDiffProcentageLabel.trailingAnchor),
			lastPriceLabel.centerYAnchor.constraint(equalTo: tikerSubLabel.centerYAnchor),
		])
	}

	func setupCell(with model: StockViewModel) {

		if let tiker = model.tiker?.lowercased(), let url = URL(string: "https://tradernet.ru/logos/get-logo-by-ticker?ticker=\(tiker)") {
			tikerImageView.kf.setImage(with: url) { result in
				switch result {
				case .success(let image):
					print(image)
				case .failure: break
				}
			}
		}

		tikerLabel.text = model.tiker
		tikerSubLabel.text = "\(model.lastStockExchange ?? "") | \(model.name ?? "")"
		closeSessionDiffProcentageLabel.text = "\(model.closeSessionDiffProcentage ?? 0)%"

		lastPriceLabel.text = "\(model.lastPrice ?? 0) ( \(model.lastDealDiffPrice ?? 0) )"

	}
}
