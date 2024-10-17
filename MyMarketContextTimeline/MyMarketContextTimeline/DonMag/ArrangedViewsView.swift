//
//  ArrangedViewsView.swift
//  MyMarketContextTimeline
//
//  Created by Don Mag on 10/15/24.
//

import UIKit

/*
class ArrangedViewsView: UIView {
	
	public var theStrings: [String] = [] {
		didSet {
			// remove existing views
			for v in labelViews { v.removeFromSuperview() }
			labelViews = []
			for str in theStrings {
				let t = PaddedLabelView()
				t.font = font
				t.text = str
				t.cornerRadius = tagCornerRadius
				t.backgroundColor = bkgColor
				addSubview(t)
				labelViews.append(t)
			}
			calcFrames(bounds.width)
		}
	}
	
	// properties "passed through" to the label views
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
	public var bkgColor: UIColor = .white {
		didSet {
			for v in labelViews {
				v.backgroundColor = bkgColor
			}
		}
	}
	// corner radius
	public var tagCornerRadius: CGFloat = 0.0 {
		didSet {
			for v in labelViews {
				v.cornerRadius = tagCornerRadius
			}
		}
	}
	
	// if we change any of these, we need to re-layout the views
	
	// "padding" for views
	public var edgePadding: CGSize = .init(width: 8.0, height: 8.0) { didSet { calcFrames(bounds.width) } }
	
	// "padding" for label embedded in label view
	public var tagPadding: CGSize = .init(width: 6.0, height: 4.0) { didSet { calcFrames(bounds.width) } }
	
	// horizontal space between label views
	public var tagSpace: CGFloat = 12.0 { didSet { calcFrames(bounds.width) } }
	
	// vertical space between "rows"
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
		// at some point, we may need to do something on init
	}
	
	func calcFrames(_ newW: CGFloat) {
		// this can be called multiple times, and
		//	may be called before we have a frame
		if newW == 0.0 {
			return
		}
		
		let oldWidth = myWidth
		let oldHeight = myHeight
		myHeight = 0.0
		myWidth = 0.0
		
		for v in labelViews {
			v.frame.origin = .zero
		}
		
		var x: CGFloat = edgePadding.width
		var y: CGFloat = edgePadding.height
		
		var isMultiLine: Bool = false
		var thisRect: CGRect = .zero
		
		for thisView in labelViews {
			thisView.textColor = textColor
			// set the label-to-view padding
			thisView.insets = .init(top: tagPadding.height, left: tagPadding.width, bottom: tagPadding.height, right: tagPadding.width)
			// start with NOT needing to wrap
			isMultiLine = false
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
					isMultiLine = true
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
			if isMultiLine {
				x = edgePadding.width
				y = thisRect.maxY + lineSpace
			}
			thisView.frame = thisRect
			thisView.cornerRadius = tagCornerRadius
			// update the max width var
			myWidth = max(myWidth, thisRect.maxX)
			// if we did NOT need to wrap lines, adjust the X
			if !isMultiLine {
				x += sz.width + tagSpace
			}
		}
		
		myHeight = thisRect.maxY + edgePadding.height
		
		if oldWidth != myWidth || oldHeight != myHeight {
			invalidateIntrinsicContentSize()
			setNeedsLayout()
			layoutIfNeeded()
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
*/

class ArrangedViewsView: UIView {
	
	public var theStrings: [String] = [] {
		didSet {
			// remove existing views
			for v in labelViews { v.removeFromSuperview() }
			labelViews = []
			for str in theStrings {
				let t = PaddedLabelView()
				t.font = font
				t.text = str
				t.cornerRadius = labelViewCornerRadius
				t.backgroundColor = bkgColor
				addSubview(t)
				labelViews.append(t)
			}
			calcFrames(bounds.width)
		}
	}
	
	// properties "passed through" to the label views
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
	public var bkgColor: UIColor = .white {
		didSet {
			for v in labelViews {
				v.backgroundColor = bkgColor
			}
		}
	}
	// corner radius
	public var labelViewCornerRadius: CGFloat = 0.0 {
		didSet {
			for v in labelViews {
				v.cornerRadius = labelViewCornerRadius
			}
		}
	}
	
	// if we change any of these, we need to re-layout the views
	
	// side "padding" for arranged views
	public var edgePadding: CGSize = .init(width: 8.0, height: 8.0) { didSet { calcFrames(bounds.width) } }
	
	// "padding" for label embedded in label view
	public var labelPadding: CGSize = .init(width: 6.0, height: 4.0) { didSet { calcFrames(bounds.width) } }
	
	// horizontal space between label views
	public var interItemSpace: CGFloat = 12.0 { didSet { calcFrames(bounds.width) } }
	
	// vertical space between "rows"
	public var lineSpace: CGFloat = 6.0 { didSet { calcFrames(bounds.width) } }
	
	// we use these to set the intrinsic content size
	private var myHeight: CGFloat = 0.0
	private var myWidth: CGFloat = 0.0
	
	private var myHC: NSLayoutConstraint!
	
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
		// initialize height constraint, but don't activate it yet
		myHC = heightAnchor.constraint(equalToConstant: 0.0)
		myHC.priority = .required - 1
	}
	
	func calcFrames(_ targetWidth: CGFloat) {
		// this can be called multiple times, and
		//	may be called before we have a frame
		if targetWidth == 0.0 {
			return
		}
		
		var newWidth = 0.0
		var newHeight = 0.0
		
		var x: CGFloat = edgePadding.width
		var y: CGFloat = edgePadding.height
		
		var isMultiLine: Bool = false
		var thisRect: CGRect = .zero
		
		for thisView in labelViews {
			// these may have changed since the label views were created
			thisView.backgroundColor = bkgColor
			thisView.cornerRadius = labelViewCornerRadius
			thisView.textColor = textColor
			thisView.insets = .init(top: labelPadding.height, left: labelPadding.width, bottom: labelPadding.height, right: labelPadding.width)
			// start with NOT needing to wrap
			isMultiLine = false
			// set the frame width to a very wide value, so we get the non-wrapped size
			thisView.frame.size.width = 5000
			thisView.layoutIfNeeded()
			var sz: CGSize = thisView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
			sz.width = ceil(sz.width)
			sz.height = ceil(sz.height)
			thisRect = .init(x: x, y: y, width: sz.width, height: sz.height)
			// if this item is too wide to fit on the "row"
			if thisRect.maxX + edgePadding.width > targetWidth {
				// if this is not the FIRST item on the row
				//	move down a row and reset x
				if x > edgePadding.width {
					x = edgePadding.width
					y = thisRect.maxY + lineSpace
				}
				thisRect = .init(x: x, y: y, width: sz.width, height: sz.height)
				// if this item is still too wide to fit, that means
				//	it needs to wrap the text
				if thisRect.maxX + edgePadding.width > targetWidth {
					isMultiLine = true
					// this will give us the height based on max available width
					sz = thisView.systemLayoutSizeFitting(.init(width: targetWidth - (edgePadding.width * 2.0), height: .greatestFiniteMagnitude), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
					sz.width = ceil(sz.width)
					sz.height = ceil(sz.height)
					// update the frame
					thisView.frame.size = sz
					thisView.layoutIfNeeded()
					// this will give us the width needed for the wrapped text (instead of the max available width)
					sz = thisView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
					sz.width = ceil(sz.width)
					sz.height = ceil(sz.height)
					thisRect = .init(x: x, y: y, width: sz.width, height: sz.height)
				}
			}
			// if we needed to wrap the text, adjust the next Y and reset X
			if isMultiLine {
				x = edgePadding.width
				y = thisRect.maxY + lineSpace
			}
			thisView.frame = thisRect
			// update the max width var
			newWidth = max(newWidth, thisRect.maxX)
			// if we did NOT need to wrap lines, adjust the X
			if !isMultiLine {
				x += sz.width + interItemSpace
			}
		}
		
		newHeight = thisRect.maxY + edgePadding.height
		
		if myWidth != newWidth || myHeight != newHeight {
			myWidth = newWidth
			myHeight = newHeight
			// don't activate the constraint if we're not in an auto-layout case
			if self.translatesAutoresizingMaskIntoConstraints == false {
				myHC.isActive = true
			}
			// update the height constraint constant
			myHC.constant = myHeight
			invalidateIntrinsicContentSize()
		}

	}
	
	override var intrinsicContentSize: CGSize {
		return .init(width: myWidth, height: myHeight)
	}
	override func invalidateIntrinsicContentSize() {
		super.invalidateIntrinsicContentSize()
		
		// walk-up the view hierarchy...
		// this will handle self-sizing cells in a table or collection view, without
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
			if newValue.width != bounds.width {
				calcFrames(newValue.width)
			}
		}
	}
	
}

