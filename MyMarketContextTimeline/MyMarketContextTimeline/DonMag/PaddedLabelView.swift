//
//  PaddedLabelView.swift
//  MyMarketContextTimeline
//
//  Created by Don Mag on 10/15/24.
//

import UIKit

class PaddedLabelView: UIView {
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

