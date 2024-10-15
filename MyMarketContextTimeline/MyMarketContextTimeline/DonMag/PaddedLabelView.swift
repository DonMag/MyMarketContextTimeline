//
//  PaddedLabelView.swift
//  MyMarketContextTimeline
//
//  Created by Don Mag on 10/15/24.
//

import UIKit
import Combine

class PaddedLabelView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

class PadLabelView: UIView {
	public var insets: UIEdgeInsets = .zero {
		didSet {
			edgeConstraints[0].constant = insets.top
			edgeConstraints[1].constant = insets.left
			edgeConstraints[2].constant = -insets.right
			edgeConstraints[3].constant = -insets.bottom
		}
	}
	public var font: UIFont = .systemFont(ofSize: 16.0) { didSet { theLabel.font = font } }
	public var text: String = "" { didSet { theLabel.text = text } }
	public var textColor: UIColor = .black { didSet { theLabel.textColor = textColor } }
	public var multipleLines: Bool = true
	public let theLabel = UILabel()
	public var corner: CGFloat = 0.0 {
		didSet {
			layer.cornerRadius = corner
			layer.masksToBounds = true
		}
	}
	private var edgeConstraints: [NSLayoutConstraint] = []
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	func commonInit() {
		theLabel.numberOfLines = 0
		theLabel.font = font
		theLabel.translatesAutoresizingMaskIntoConstraints = false
		addSubview(theLabel)
		edgeConstraints = [
			theLabel.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
			theLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
			theLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets.right),
			theLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insets.bottom),
		]
		edgeConstraints[2].priority = .required - 1
		edgeConstraints[3].priority = .required - 1
		NSLayoutConstraint.activate(edgeConstraints)
	}
}

class TagsView: UIView {
	
	public var theTags: [String] = [] { didSet { calcFrames(bounds.width) } }
	
	// properties that we want to set so we can call (for example)
	//		v.font =
	// instead of
	//		v.theLabel.font =
	public var font: UIFont = .systemFont(ofSize: 16.0, weight: .regular) {
		didSet {
			for v in tagLabels { v.font = font }
			// if we change the font, we need to re-layout the views
			calcFrames(bounds.width)
		}
	}
	public var textColor: UIColor = .black {
		didSet {
			for v in tagLabels {
				v.textColor = textColor
			}
		}
	}
	
	// background color (the embedded label will have a clear background)
	public var tagBkgColor: UIColor = .white {
		didSet {
			for v in tagLabels {
				v.backgroundColor = tagBkgColor
			}
		}
	}
	// corner radius
	public var tagCorner: CGFloat = 0.0 {
		didSet {
			for v in tagLabels {
				v.layer.cornerRadius = tagCorner
			}
		}
	}
	
	// if we change any of these, we need to re-layout the views
	public var edgePadding: CGSize = .init(width: 8.0, height: 8.0) { didSet { calcFrames(bounds.width) } }
	public var tagPadding: CGSize = .init(width: 6.0, height: 4.0) { didSet { calcFrames(bounds.width) } }
	public var tagSpace: CGFloat = 12.0 { didSet { calcFrames(bounds.width) } }
	public var lineSpace: CGFloat = 6.0 { didSet { calcFrames(bounds.width) } }
	
	// we use these to set the intrinsic content size
	private var myHeight: CGFloat = 0.0
	private var myWidth: CGFloat = 0.0
	
	private var tagLabels: [PadLabelView] = []
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	private func commonInit() {
		// let's assume we will have a max of 100 items
		//	if we need more, we probably shouldn't be using this layout
		for _ in 0..<99 {
			let t = PadLabelView()
			t.layer.masksToBounds = true
			t.font = font
			t.backgroundColor = tagBkgColor
			addSubview(t)
			tagLabels.append(t)
		}
	}
	
	func calcFrames(_ newW: CGFloat) {
		if newW == 0.0 {
			return
		}
		
		myHeight = 0.0
		myWidth = 0.0
		
		for v in tagLabels {
			v.frame.origin = .zero
			v.isHidden = true
		}
		
		var x: CGFloat = edgePadding.width
		var y: CGFloat = edgePadding.height
		
		var thisRect: CGRect = .zero
		myWidth = 0.0
		for (thisLabel, thisTag) in zip(tagLabels, theTags) {
			thisLabel.isHidden = false
			// set the text
			thisLabel.text = thisTag
			// set the label-to-view padding
			thisLabel.insets = .init(top: tagPadding.height, left: tagPadding.width, bottom: tagPadding.height, right: tagPadding.width)
			// start with NOT needing to wrap
			thisLabel.multipleLines = false
			// set the frame width to a very wide value, so we get the non-wrapped size
			thisLabel.frame.size.width = 5000
			thisLabel.layoutIfNeeded()
			var sz: CGSize = thisLabel.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
			sz.width = ceil(sz.width)
			sz.height = ceil(sz.height)
			thisRect = .init(x: x, y: y, width: sz.width, height: sz.height)
			// if this item is too wide to fit on the "row"
			//	move down a row and reset x
			if thisRect.maxX + edgePadding.width > newW {
				x = edgePadding.width
				y = thisRect.maxY + lineSpace
				thisRect = .init(x: x, y: y, width: sz.width, height: sz.height)
				// if this item is still too wide to fit, that means
				//	it needs to wrap the text
				if thisRect.maxX + edgePadding.width > newW {
					thisLabel.multipleLines = true
					// this will give us the height based on max available width
					sz = thisLabel.systemLayoutSizeFitting(.init(width: newW - (edgePadding.width * 2.0), height: .greatestFiniteMagnitude), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
					sz.width = ceil(sz.width)
					sz.height = ceil(sz.height)
					// update the frame
					thisLabel.frame.size = sz
					thisLabel.layoutIfNeeded()
					// this will give us the width needed for the text (instead of the max available width)
					sz = thisLabel.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
					sz.width = ceil(sz.width)
					sz.height = ceil(sz.height)
					thisRect = .init(x: x, y: y, width: sz.width, height: sz.height)
				}
			}
			// if we needed to wrap the text, adjust the next Y and reset X
			if thisLabel.multipleLines {
				x = edgePadding.width
				y = thisRect.maxY + lineSpace
			}
			thisLabel.frame = thisRect
			thisLabel.layer.cornerRadius = tagCorner
			// update the max width var
			myWidth = max(myWidth, thisRect.maxX)
			// if we did NOT need to wrap lines, adjust the X
			if !thisLabel.multipleLines {
				x += sz.width + tagSpace
			}
		}
		
		y = thisRect.maxY + edgePadding.height
		
		if myHeight != y {
			myHeight = y
			invalidateIntrinsicContentSize()
		}
	}
	
	override var intrinsicContentSize: CGSize {
		return .init(width: myWidth, height: myHeight)
	}
	override func invalidateIntrinsicContentSize() {
		super.invalidateIntrinsicContentSize()
		// this will handle self-sizing cells, without
		//	the need to "call back" to the controller
		var sv = superview
		while sv != nil {
			if sv is UITableViewCell || sv is UICollectionViewCell {
				sv?.invalidateIntrinsicContentSize()
				sv = nil
			} else {
				sv = sv?.superview
			}
		}
	}
	
	override var bounds: CGRect {
		willSet {
			if newValue.width > 0.0 {
				calcFrames(newValue.width)
			}
		}
	}
	
}

class DM_CardTableViewCell: UITableViewCell {
	static let identifier: String = "CardTableViewCell"
	
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
	
	let assetsTagsView: TagsView = {
		let v = TagsView()
		v.tagPadding = .init(width: 8.0, height: 2.0)
		v.edgePadding = .zero
		v.tagCorner = 6.0
		v.tagBkgColor = .systemBlue
		v.textColor = .white
		v.font = .systemFont(ofSize: 12.0, weight: .bold)
		return v
	}()
	
	let benchmarksTagsView: TagsView = {
		let v = TagsView()
		v.tagPadding = .init(width: 8.0, height: 2.0)
		v.edgePadding = .zero
		v.tagCorner = 6.0
		v.tagBkgColor = .systemGreen
		v.textColor = .white
		v.font = .systemFont(ofSize: 12.0, weight: .bold)
		return v
	}()
	
	var assetsCollectionView: AssetsCollectionView = {
		let collectionView = AssetsCollectionView()
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		
		return collectionView
	}()
	
	lazy var benchmarksCollectionView: BenchmarksCollectionView = {
		let collectionView = BenchmarksCollectionView()
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		
		return collectionView
	}()
	
	weak var delegate: CardTableViewCellDelegate?
	
	// MARK: - Init
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
//	override func systemLayoutSizeFitting(_ targetSize: CGSize) -> CGSize {
//		assetsCollectionView.layoutIfNeeded()
//		assetsCollectionView.frame = CGRect(x: 0, y: 0, width: targetSize.width , height: 1)
//		return assetsCollectionView.collectionViewLayout.collectionViewContentSize
//	}
	
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
			assetsTagsView.theTags = assets.map { $0.stockName }
			containerStackView.addArrangedSubview(assetsTagsView)
		}
	}

	private func configureBenchmarksTagsView(with model: [Benchmark]?) {
		if let benchmarks = model {
			benchmarksTagsView.theTags = benchmarks.map { "\($0.title) \($0.rentability)%" }
			containerStackView.addArrangedSubview(benchmarksTagsView)
		}
	}
	
//	private func configureAssetsCollectionView(with model: [Asset]?) {
//		if let assets = model {
//			assetsCollectionView.configure(with: assets)
//			
//			containerStackView.addArrangedSubview(assetsCollectionView)
//			
//			//            assetsCollectionView.updateConstraints()
//			//            delegate?.updateTableView()
//			
//			contentView.layoutIfNeeded()
//		}
//	}
	
//	private func configurebenchmarksCollectionView(with model: [Benchmark]?) {
//		if let benchmarks = model {
//			benchmarksCollectionView.configure(with: benchmarks)
//			
//			containerStackView.addArrangedSubview(benchmarksCollectionView)
//		}
//	}
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
			
			//assetsCollectionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 22),
			benchmarksCollectionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 22)
		])
	}
}

final class DM_TimelineViewController: UIViewController, CardTableViewCellDelegate {
	private let viewModel = TimelineViewModel()
	private let timelineView = DM_TimelineView()
	private var cancellables = Set<AnyCancellable>()
	
	override func loadView() {
		self.view = timelineView
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		bindViewModel()
		setupTableViewDataSource()
		
		viewModel.fetchCards()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		//navigationController?.setNavigationBarHidden(true, animated: false)
	}
	
	private func bindViewModel() {
		viewModel.$cards
			.receive(on: DispatchQueue.main)
			.sink { [weak self] _ in
				self?.timelineView.tableView.reloadData()
			}
			.store(in: &cancellables)
	}
	
	private func setupTableViewDataSource() {
		timelineView.tableView.dataSource = self
	}
}

// MARK: - UITableViewDataSource
extension DM_TimelineViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.cards.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView
			.dequeueReusableCell(withIdentifier: DM_CardTableViewCell.identifier, for: indexPath) as? DM_CardTableViewCell else {
			return UITableViewCell()
		}
		
		let card = viewModel.cards[indexPath.row]
		cell.delegate = self
		cell.configure(with: card)
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
	
	func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
	
	func updateTableView() {
		timelineView.tableView.beginUpdates()
		timelineView.tableView.endUpdates()
	}
}

class DM_TimelineView: UIView {
	lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.text = "Market Context"
		label.font = .preferredFont(forTextStyle: .largeTitle)
		label.numberOfLines = 0
		
		return label
	}()
	
	internal lazy var tableView = UITableView()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupTableView()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setupTableView() {
		backgroundColor = .systemGray5
		
		tableView.translatesAutoresizingMaskIntoConstraints = false
		
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 150
		tableView.register(DM_CardTableViewCell.self, forCellReuseIdentifier: DM_CardTableViewCell.identifier)
		
		addSubview(titleLabel)
		addSubview(tableView)
		
		// Constraints for full-screen table view layout
		NSLayoutConstraint.activate([
			titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 28),
			titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 28),
			titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -28),
			
			tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 28),
			tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
		])
	}
}
