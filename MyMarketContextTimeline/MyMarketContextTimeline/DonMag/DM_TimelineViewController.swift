//
//  DM_TimelineViewController.swift
//  MyMarketContextTimeline
//
//  Created by Don Mag on 10/15/24.
//

import UIKit
import Combine

final class DM_TimelineViewController: UIViewController {
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
		cell.configure(with: card)
		
		return cell
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
	
	func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
}

