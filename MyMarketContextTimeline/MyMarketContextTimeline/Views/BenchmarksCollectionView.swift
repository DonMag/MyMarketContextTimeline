//
//  BenchmarksCollectionView.swift
//  MarketContextTimeline
//
//  Created by Ramon Ferreira on 10/10/24.
//

import UIKit

final class BenchmarksCollectionView: UICollectionView {
    private var benchmarks: [Benchmark] = []
    
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return self.collectionViewLayout.collectionViewContentSize
    }
    
    init() {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        super.init(frame: .zero, collectionViewLayout: layout)
        
        delegate = self
        dataSource = self
        register(BenchmarkCollectionViewCell.self,
                 forCellWithReuseIdentifier: BenchmarkCollectionViewCell.identifier)
        
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with benchmarks: [Benchmark]) {
        self.benchmarks = benchmarks
        reloadData()
    }
}

extension BenchmarksCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return benchmarks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: BenchmarkCollectionViewCell.identifier, for: indexPath) as? BenchmarkCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: benchmarks[indexPath.row])
        
        return cell
    }
}
