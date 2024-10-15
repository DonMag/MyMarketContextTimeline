//
//  AssetsCollectionView.swift
//  MarketContextTimeline
//
//  Created by Ramon Ferreira on 10/10/24.
//

import UIKit

class AssetsCollectionView: UICollectionView {
    private var assets: [Asset] = []
    
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        print(contentSize)
        return self.contentSize
    }
    
    init() {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        super.init(frame: .zero, collectionViewLayout: layout)
        
        delegate = self
        dataSource = self
        
        register(AssetCollectionViewCell.self,
                 forCellWithReuseIdentifier: AssetCollectionViewCell.identifier)
        
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with assets: [Asset]) {
        self.assets = assets
        reloadData()
    }
}

extension AssetsCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: AssetCollectionViewCell.identifier, for: indexPath) as? AssetCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: assets[indexPath.row])
        
        return cell
    }
}
