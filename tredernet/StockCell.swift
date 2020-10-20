//
//  StockCell.swift
//  tredernet
//
//  Created by Shlyapkin Ivan on 18.10.2020.
//

import UIKit
import Kingfisher

final class StockCell: UITableViewCell {

	private var tickerImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()

	private var tickerLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 20)
		label.textColor = .black
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	private var tickerSubLabel: UILabel = {
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
		view.backgroundColor = .clear
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

	private var tickerLabelConstaint: NSLayoutConstraint?

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		accessoryType = .disclosureIndicator
		setup()
	}

	required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

	private func setup() {
		contentView.addSubview(tickerImageView)
		contentView.addSubview(tickerLabel)
		contentView.addSubview(tickerSubLabel)
		contentView.addSubview(diffProcentageContainerView)
		contentView.addSubview(closeSessionDiffProcentageLabel)
		contentView.addSubview(lastPriceLabel)

		tickerLabelConstaint = tickerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
		tickerLabelConstaint?.isActive = true

		NSLayoutConstraint.activate([
			tickerImageView.heightAnchor.constraint(equalToConstant: 16),
			tickerImageView.widthAnchor.constraint(equalToConstant: 16),
			tickerImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			tickerImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),

			tickerLabel.centerYAnchor.constraint(equalTo: tickerImageView.centerYAnchor),

			tickerSubLabel.leadingAnchor.constraint(equalTo: tickerImageView.leadingAnchor),
			tickerSubLabel.trailingAnchor.constraint(equalTo: lastPriceLabel.leadingAnchor),
			tickerSubLabel.topAnchor.constraint(equalTo: tickerImageView.bottomAnchor, constant: 10),
			tickerSubLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),

			closeSessionDiffProcentageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
			closeSessionDiffProcentageLabel.centerYAnchor.constraint(equalTo: tickerImageView.centerYAnchor),

			diffProcentageContainerView.trailingAnchor.constraint(equalTo: closeSessionDiffProcentageLabel.trailingAnchor, constant: 3),
			diffProcentageContainerView.centerYAnchor.constraint(equalTo: closeSessionDiffProcentageLabel.centerYAnchor),
			diffProcentageContainerView.bottomAnchor.constraint(equalTo: closeSessionDiffProcentageLabel.bottomAnchor, constant: 3),
			diffProcentageContainerView.centerXAnchor.constraint(equalTo: closeSessionDiffProcentageLabel.centerXAnchor),

			lastPriceLabel.trailingAnchor.constraint(equalTo: closeSessionDiffProcentageLabel.trailingAnchor),
			lastPriceLabel.centerYAnchor.constraint(equalTo: tickerSubLabel.centerYAnchor),
		])
	}

	func setupCell(with model: StockViewModel) {

		if let url = URL(string: "https://tradernet.ru/logos/get-logo-by-ticker?ticker=\(model.titleText.lowercased())") {
			tickerImageView.kf.setImage(with: url, completionHandler:  { result in
				switch result {
				case .success(let image):
					let imgData = image.image.pngData() ?? Data()
					self.tickerLabelConstaint?.constant = imgData.count < 100 ? 16 : 40
				case .failure: break
				}
			})
		}

		tickerLabel.text = model.titleText
		tickerSubLabel.text = model.subtitleText

		if !model.priceProcentageText.isEmpty {
			closeSessionDiffProcentageLabel.text = model.priceProcentageText
		}

		if !model.lastPriceText.isEmpty {
			lastPriceLabel.text = model.lastPriceText
		}

		let greenColor = UIColor(red: 0, green: 0.6078, blue: 0.0392, alpha: 1)

		if model.isNeedAnimation && !model.priceProcentageText.isEmpty {

			closeSessionDiffProcentageLabel.textColor = .white
			diffProcentageContainerView.backgroundColor = model.isMoreZero ? greenColor : .red

			DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
				self.closeSessionDiffProcentageLabel.textColor = model.isMoreZero ? greenColor : .red
				self.diffProcentageContainerView.backgroundColor = .clear
			}
		} else {
			self.closeSessionDiffProcentageLabel.textColor = model.isMoreZero ? greenColor : .red
		}
	}
}
