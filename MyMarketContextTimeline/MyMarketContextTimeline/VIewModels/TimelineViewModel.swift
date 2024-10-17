//
//  TimelineViewModel.swift
//  MarketContextTimeline
//
//  Created by Ramon Ferreira on 10/10/24.
//

import Foundation
import Combine

final class TimelineViewModel {
    @Published var cards: [Card] = []
    private var cancellables: Set<AnyCancellable> = []
    
	func fetchCards() {
		// Simulate network fetching
		//DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
			
			var fetchCards: [Card]
			
//			fetchCards = [
//				Card(title: "Notice 1",
//					 subtitle: "This is a sample notice to present the timeline, it can be a long text",
//					 sourceNew: "my head",
//					 assets: [
//						Asset(stockName: "MGLU3"),
//						Asset(stockName: "IBVV11"),
//						Asset(stockName: "BBSA3"),
//						Asset(stockName: "Hash Index Ethereum position replicated with a 100% accuracy"),
//					 ],
//					 benchmarks: [ Benchmark(title: "IPCA", rentability: -2) ]),
//				
//				Card(title: "Notice 2",
//					 subtitle: "Teste notice subtitle",
//					 sourceNew: nil,
//					 assets: [ Asset(stockName: "BBSA3") ],
//					 benchmarks: [ Benchmark(title: "IPCA", rentability: -2),
//								   Benchmark(title: "CDI", rentability: 100),
//								   Benchmark(title: "Poupança", rentability: 50)]),
//				
//				Card(title: "Notice 3",
//					 subtitle: "This is a sample notice to present the timeline, it can be a long text",
//					 sourceNew: nil,
//					 assets: nil,
//					 benchmarks: [ Benchmark(title: "IPTU", rentability: -10) ]),
//			]
			
				fetchCards = [
					Card(title: "Notice 1",
						 subtitle: "This is a sample notice to present the timeline, it can be a long text",
						 sourceNew: "my head",
						 assets: [
							Asset(stockName: "MGLU3"),
							Asset(stockName: "IBVV11"),
							Asset(stockName: "BBSA3"),
							Asset(stockName: "Hash Index Ethereum position replicated with a 100% accuracy"),
						 ],
						 benchmarks: [
							Benchmark(title: "IPCA", rentability: -2)
						 ]
						),
					
					Card(title: "Notice 2",
						 subtitle: "Teste notice subtitle",
						 sourceNew: nil,
						 assets: [
							Asset(stockName: "BBSA3"),
						 ],
						 benchmarks: [
							Benchmark(title: "IPCA", rentability: -2),
							Benchmark(title: "CDI", rentability: 100),
							Benchmark(title: "Poupança", rentability: 50),
						 ]
						),
					
					Card(title: "Notice 3",
						 subtitle: "This is a sample notice to present the timeline, it can be a long text",
						 sourceNew: nil,
						 assets: nil,
						 benchmarks: [
							Benchmark(title: "IPTU", rentability: -10),
						 ]
						),
					
					Card(title: "Notice 4",
						 subtitle: "This sample has more Assets and Benchmarks notice to present the timeline, it can be a long text",
						 sourceNew: "Samples",
						 assets: [
							Asset(stockName: "MGLU3"),
							Asset(stockName: "IBVV11"),
							Asset(stockName: "BBSA3"),
							Asset(stockName: "Hash Index Ethereum position replicated with a 100% accuracy"),
							Asset(stockName: "FIFTH"),
							Asset(stockName: "SIXTH"),
							Asset(stockName: "SEVENTH item"),
							Asset(stockName: "EIGHTH"),
							Asset(stockName: "NINTH"),
							Asset(stockName: "TENTH item has longer text, so it will probably wrap onto multiple lines. Let's make it so long it will need more than two lines."),
							Asset(stockName: "ELEVENTH"),
						 ],
						 benchmarks: [
							Benchmark(title: "IPCA", rentability: -2),
							Benchmark(title: "CDI", rentability: 100),
							Benchmark(title: "Poupança", rentability: 50),
						 ]
						),
					
					Card(title: "Notice 5",
						 subtitle: "This is a sample notice",
						 sourceNew: "my head 5",
						 assets: [
							Asset(stockName: "ONE"),
							Asset(stockName: "TWO"),
							Asset(stockName: "THREE"),
							Asset(stockName: "Hash Index Ethereum position replicated with a 100% accuracy"),
							Asset(stockName: "FOUR"),
							Asset(stockName: "FIVE"),
							Asset(stockName: "Another longer stock name"),
							Asset(stockName: "SIX"),
						 ],
						 benchmarks: [
							Benchmark(title: "IPCA", rentability: -2)
						 ]
						),
					
				]
			
			// let's add another 4 sets so we can scroll and
			//	see if we have cell reuse issues
			var moreCards: [Card] = []
			moreCards.append(contentsOf: fetchCards)
			for i in 1...4 {
				var tmp: [Card] = []
				for j in 0..<fetchCards.count {
					var c = fetchCards[j]
					let t = c.title ?? "title"
					c.title = t + " : \(i)"
					tmp.append(c)
				}
				moreCards.append(contentsOf: tmp)
			}
			
			self.cards = moreCards
			//self.cards = fetchCards
		}
	}
}
