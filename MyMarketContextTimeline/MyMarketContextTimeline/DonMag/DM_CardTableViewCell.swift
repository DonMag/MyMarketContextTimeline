//
//  DM_CardTableViewCell.swift
//  MyMarketContextTimeline
//
//  Created by Don Mag on 10/15/24.
//

import UIKit

class DM_CardTableViewCell: UITableViewCell {
	static let identifier: String = "DM_CardTableViewCell"
	
	lazy var cardView: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.layer.cornerRadius = 8
		view.layer.masksToBounds = true
		view.clipsToBounds = true
		view.layer.borderWidth = 1
		view.layer.borderColor = UIColor.separator.cgColor
		
		return view
	}()
	
	lazy var containerStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.translatesAutoresizingMaskIntoConstraints = false
		stackView.axis = .vertical
		stackView.spacing = 8
		
		return stackView
	}()
	
	lazy var title: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .preferredFont(forTextStyle: .headline)
		label.numberOfLines = 0
		
		return label
	}()
	
	lazy var subtitle: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .preferredFont(forTextStyle: .subheadline)
		label.numberOfLines = 0
		
		return label
	}()
	
	lazy var sourceNew: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = .preferredFont(forTextStyle: .footnote)
		label.numberOfLines = 0
		
		return label
	}()
	
	let assetsTagsView: ArrangedViewsView = {
		let v = ArrangedViewsView()
		v.labelPadding = .init(width: 8.0, height: 2.0)
		v.edgePadding = .zero
		v.labelViewCornerRadius = 6.0
		v.bkgColor = .systemBlue
		v.textColor = .white
		v.font = .boldSystemFont(ofSize: 12.0)
		return v
	}()
	
	let benchmarksTagsView: ArrangedViewsView = {
		let v = ArrangedViewsView()
		v.labelPadding = .init(width: 8.0, height: 2.0)
		v.edgePadding = .zero
		v.labelViewCornerRadius = 6.0
		v.bkgColor = .systemGreen
		v.textColor = .white
		v.font = .boldSystemFont(ofSize: 12.0)
		return v
	}()
	
	// MARK: - Init
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Methods
	func configure(with card: Card) {
		title.text = card.title
		subtitle.text = card.subtitle
		sourceNew.text = card.sourceNew
		
		configureAssetsTagsView(with: card.assets)
		configureBenchmarksTagsView(with: card.benchmarks)
	}
	
	private func configureAssetsTagsView(with model: [Asset]?) {
		if let assets = model {
			assetsTagsView.theStrings = assets.map { $0.stockName }
			containerStackView.addArrangedSubview(assetsTagsView)
		}
	}
	
	private func configureBenchmarksTagsView(with model: [Benchmark]?) {
		if let benchmarks = model {
			benchmarksTagsView.theStrings = benchmarks.map { "\($0.title) \($0.rentability)%" }
			containerStackView.addArrangedSubview(benchmarksTagsView)
		}
	}
	
}

// MARK: - ViewCode
extension DM_CardTableViewCell {
	func setupView() {
		setupLayout()
		setupHierarchy()
		setupConstrains()
	}
	
	func setupLayout() {
		backgroundColor = .white
		cardView.backgroundColor = .clear
	}
	
	func setupHierarchy() {
		[title,
		 subtitle,
		 sourceNew].forEach(containerStackView.addArrangedSubview(_:))
		
		cardView.addSubview(containerStackView)
		
		contentView.addSubview(cardView)
	}
	
	func setupConstrains() {
		NSLayoutConstraint.activate([
			cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
			cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
			cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
			cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
			
			containerStackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 8),
			containerStackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 8),
			containerStackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -8),
			containerStackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -8),
		])
	}
}

