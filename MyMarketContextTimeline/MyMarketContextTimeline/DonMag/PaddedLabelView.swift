//
//  PaddedLabelView.swift
//  MyMarketContextTimeline
//
//  Created by Don Mag on 10/15/24.
//

import UIKit

// UIView with embedded UILabel
// roughly equivalent to a cell
class PaddedLabelView: UIView {
	
	// "padding" around the label
	public var insets: UIEdgeInsets = .zero {
		didSet {
			edgeConstraints[0].constant = insets.top
			edgeConstraints[1].constant = insets.left
			edgeConstraints[2].constant = -insets.right
			edgeConstraints[3].constant = -insets.bottom
		}
	}

	// for rounded corners
	public var cornerRadius: CGFloat = 0.0 {
		didSet {
			layer.cornerRadius = cornerRadius
			layer.masksToBounds = true
		}
	}

	// properties that we want to set so we can call (for example)
	//		.font =
	// instead of
	//		.theLabel.font =
	public var font: UIFont = .systemFont(ofSize: 16.0) { didSet { theLabel.font = font } }
	public var text: String = "" { didSet { theLabel.text = text } }
	public var textColor: UIColor = .black { didSet { theLabel.textColor = textColor } }

	private let theLabel = UILabel()
	
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
		// this prevents auto-layout complaints
		edgeConstraints[2].priority = .required - 1
		edgeConstraints[3].priority = .required - 1
		NSLayoutConstraint.activate(edgeConstraints)
	}
}

