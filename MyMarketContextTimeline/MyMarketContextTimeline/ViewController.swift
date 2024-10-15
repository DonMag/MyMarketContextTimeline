//
//  ViewController.swift
//  MyMarketContextTimeline
//
//  Created by Don Mag on 10/15/24.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		
		var cfg = UIButton.Configuration.filled()
		
		cfg.title = "Original Collection Views"
		
		let b1 = UIButton(configuration: cfg, primaryAction: UIAction() { _ in
			let vc = TimelineViewController()
			vc.title = "Original"
			self.navigationController?.pushViewController(vc, animated: true)
		})
		
		cfg.title = "Using Custom Views"
		
		let b2 = UIButton(configuration: cfg, primaryAction: UIAction() { _ in
			let vc = DM_TimelineViewController()
			vc.title = "Custom Views"
			self.navigationController?.pushViewController(vc, animated: true)
		})
		
		b1.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(b1)
		b2.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(b2)

		let g = view.safeAreaLayoutGuide
		NSLayoutConstraint.activate([
			b1.topAnchor.constraint(equalTo: g.topAnchor, constant: 40.0),
			b1.centerXAnchor.constraint(equalTo: g.centerXAnchor),
			b2.topAnchor.constraint(equalTo: b1.bottomAnchor, constant: 40.0),
			b2.centerXAnchor.constraint(equalTo: g.centerXAnchor),
		])

		
	}


}

