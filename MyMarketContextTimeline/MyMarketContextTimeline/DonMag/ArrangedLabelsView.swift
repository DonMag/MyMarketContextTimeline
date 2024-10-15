//
//  ArrangedLabelsView.swift
//  MyMarketContextTimeline
//
//  Created by Don Mag on 10/15/24.
//

import UIKit

class ArrangedLabelsView: UIView {
	
	public var theStrings: [String] = [] { didSet { calcFrames(bounds.width) } }
	
	// properties that we want to set so we can call (for example)
	//		v.font =
	// instead of
	//		v.theLabel.font =
	public var font: UIFont = .systemFont(ofSize: 16.0, weight: .regular) {
		didSet {
			for v in labelViews { v.font = font }
			// if we change the font, we need to re-layout the views
			calcFrames(bounds.width)
		}
	}
	public var textColor: UIColor = .black {
		didSet {
			for v in labelViews {
				v.textColor = textColor
			}
		}
	}
	
	// background color (the embedded label will have a clear background)
	public var tagBkgColor: UIColor = .white {
		didSet {
			for v in labelViews {
				v.backgroundColor = tagBkgColor
			}
		}
	}
	// corner radius
	public var tagCorner: CGFloat = 0.0 {
		didSet {
			for v in labelViews {
				v.layer.cornerRadius = tagCorner
			}
		}
	}
	
	// if we change any of these, we need to re-layout the views
	public var edgePadding: CGSize = .init(width: 8.0, height: 8.0) { didSet { calcFrames(bounds.width) } }
	public var tagPadding: CGSize = .init(width: 6.0, height: 4.0) { didSet { calcFrames(bounds.width) } }
	public var tagSpace: CGFloat = 12.0 { didSet { calcFrames(bounds.width) } }
	public var lineSpace: CGFloat = 6.0 { didSet { calcFrames(bounds.width) } }
	
	// we use these to set the intrinsic content size
	private var myHeight: CGFloat = 0.0
	private var myWidth: CGFloat = 0.0
	
	private var labelViews: [PaddedLabelView] = []
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		commonInit()
	}
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		commonInit()
	}
	private func commonInit() {
		// let's assume we will have a max of 100 items
		//	if we need more, we probably shouldn't be using this layout
		for _ in 0..<99 {
			let t = PaddedLabelView()
			t.layer.masksToBounds = true
			t.font = font
			t.backgroundColor = tagBkgColor
			addSubview(t)
			labelViews.append(t)
		}
	}
	
	func calcFrames(_ newW: CGFloat) {
		if newW == 0.0 {
			return
		}
		
		myHeight = 0.0
		myWidth = 0.0
		
		for v in labelViews {
			v.frame.origin = .zero
			v.isHidden = true
		}
		
		var x: CGFloat = edgePadding.width
		var y: CGFloat = edgePadding.height
		
		var thisRect: CGRect = .zero
		myWidth = 0.0
		for (thisView, thisString) in zip(labelViews, theStrings) {
			thisView.isHidden = false
			// set the text
			thisView.text = thisString
			// set the label-to-view padding
			thisView.insets = .init(top: tagPadding.height, left: tagPadding.width, bottom: tagPadding.height, right: tagPadding.width)
			// start with NOT needing to wrap
			thisView.multipleLines = false
			// set the frame width to a very wide value, so we get the non-wrapped size
			thisView.frame.size.width = 5000
			thisView.layoutIfNeeded()
			var sz: CGSize = thisView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
			sz.width = ceil(sz.width)
			sz.height = ceil(sz.height)
			thisRect = .init(x: x, y: y, width: sz.width, height: sz.height)
			// if this item is too wide to fit on the "row"
			//	move down a row and reset x
			if thisRect.maxX + edgePadding.width > newW {
				x = edgePadding.width
				y = thisRect.maxY + lineSpace
				thisRect = .init(x: x, y: y, width: sz.width, height: sz.height)
				// if this item is still too wide to fit, that means
				//	it needs to wrap the text
				if thisRect.maxX + edgePadding.width > newW {
					thisView.multipleLines = true
					// this will give us the height based on max available width
					sz = thisView.systemLayoutSizeFitting(.init(width: newW - (edgePadding.width * 2.0), height: .greatestFiniteMagnitude), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
					sz.width = ceil(sz.width)
					sz.height = ceil(sz.height)
					// update the frame
					thisView.frame.size = sz
					thisView.layoutIfNeeded()
					// this will give us the width needed for the text (instead of the max available width)
					sz = thisView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
					sz.width = ceil(sz.width)
					sz.height = ceil(sz.height)
					thisRect = .init(x: x, y: y, width: sz.width, height: sz.height)
				}
			}
			// if we needed to wrap the text, adjust the next Y and reset X
			if thisView.multipleLines {
				x = edgePadding.width
				y = thisRect.maxY + lineSpace
			}
			thisView.frame = thisRect
			thisView.layer.cornerRadius = tagCorner
			// update the max width var
			myWidth = max(myWidth, thisRect.maxX)
			// if we did NOT need to wrap lines, adjust the X
			if !thisView.multipleLines {
				x += sz.width + tagSpace
			}
		}
		
		y = thisRect.maxY + edgePadding.height
		
		if myHeight != y {
			myHeight = y
			invalidateIntrinsicContentSize()
		}
	}
	
	override var intrinsicContentSize: CGSize {
		return .init(width: myWidth, height: myHeight)
	}
	override func invalidateIntrinsicContentSize() {
		super.invalidateIntrinsicContentSize()
		// this will handle self-sizing cells, without
		//	the need to "call back" to the controller
		var sv = superview
		while sv != nil {
			if sv is UITableViewCell || sv is UICollectionViewCell {
				sv?.invalidateIntrinsicContentSize()
				sv = nil
			} else {
				sv = sv?.superview
			}
		}
	}
	
	override var bounds: CGRect {
		willSet {
			if newValue.width > 0.0 {
				calcFrames(newValue.width)
			}
		}
	}
	
}

