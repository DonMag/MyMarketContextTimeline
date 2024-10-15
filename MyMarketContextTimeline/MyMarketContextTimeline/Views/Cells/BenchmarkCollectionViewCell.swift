//
//  BenchmarkCollectionViewCell.swift
//  MarketContextTimeline
//
//  Created by Ramon Ferreira on 10/10/24.
//

import UIKit

final class BenchmarkCollectionViewCell: UICollectionViewCell {
    static let identifier: String = "BenchmarkCollectionViewCell"
    
    private let roundedView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGreen
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    private let titleLabel: UILabel = {
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
        roundedView.addSubview(titleLabel)
        contentView.addSubview(roundedView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(lessThanOrEqualToConstant: 120),
            
            roundedView.topAnchor.constraint(equalTo: contentView.topAnchor),
            roundedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            roundedView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            roundedView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: roundedView.topAnchor, constant: 2),
            titleLabel.leadingAnchor.constraint(equalTo: roundedView.leadingAnchor, constant: 6),
            titleLabel.trailingAnchor.constraint(equalTo: roundedView.trailingAnchor, constant: -6),
            titleLabel.bottomAnchor.constraint(equalTo: roundedView.bottomAnchor, constant: -2)
        ])
    }
    
    func configure(with benchmark: Benchmark) {
        titleLabel.text = "\(benchmark.title) \(benchmark.rentability)%"
    }
}
