//
//  CardTableViewCell.swift
//  MarketContextTimeline
//
//  Created by Ramon Ferreira on 10/10/24.
//

import UIKit

protocol CardTableViewCellDelegate: AnyObject {
    func updateTableView()
}

class CardTableViewCell: UITableViewCell {
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
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize) -> CGSize {
        assetsCollectionView.layoutIfNeeded()
        assetsCollectionView.frame = CGRect(x: 0, y: 0, width: targetSize.width , height: 1)
        return assetsCollectionView.collectionViewLayout.collectionViewContentSize
    }
    
    // MARK: - Methods
    func configure(with card: Card) {
        title.text = card.title
        subtitle.text = card.subtitle
        sourceNew.text = card.sourceNew
        
        configureAssetsCollectionView(with: card.assets)
        configurebenchmarksCollectionView(with: card.benchmarks)
    }
    
    private func configureAssetsCollectionView(with model: [Asset]?) {
        if let assets = model {
            assetsCollectionView.configure(with: assets)
            
            containerStackView.addArrangedSubview(assetsCollectionView)
            
//            assetsCollectionView.updateConstraints()
//            delegate?.updateTableView()
            
            contentView.layoutIfNeeded()
        }
    }
    
    private func configurebenchmarksCollectionView(with model: [Benchmark]?) {
        if let benchmarks = model {
            benchmarksCollectionView.configure(with: benchmarks)
            
            containerStackView.addArrangedSubview(benchmarksCollectionView)
        }
    }
}

// MARK: - ViewCode
extension CardTableViewCell {
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
            
            assetsCollectionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 22),
            benchmarksCollectionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 22)
        ])
    }
}
