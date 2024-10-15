//
//  AssetCollectionViewCell.swift
//  MarketContextTimeline
//
//  Created by Ramon Ferreira on 10/10/24.
//

import UIKit

final class AssetCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "AssetCollectionViewCell"
    
    private let roundedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    private let stockNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 0
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        roundedView.addSubview(stockNameLabel)
        contentView.addSubview(roundedView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(lessThanOrEqualToConstant: 326),
            
            roundedView.topAnchor.constraint(equalTo: contentView.topAnchor),
            roundedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            roundedView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            roundedView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            stockNameLabel.topAnchor.constraint(equalTo: roundedView.topAnchor, constant: 2),
            stockNameLabel.leadingAnchor.constraint(equalTo: roundedView.leadingAnchor, constant: 8),
            stockNameLabel.trailingAnchor.constraint(equalTo: roundedView.trailingAnchor, constant: -8),
            stockNameLabel.bottomAnchor.constraint(equalTo: roundedView.bottomAnchor, constant: -2),
        ])
    }
    
    func configure(with asset: Asset) {
        stockNameLabel.text = asset.stockName
    }
}
