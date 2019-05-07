//
//  Bar.swift
//  Bar
//
//  Created by Barbara Correia on 23/04/2019.
//  Copyright © 2019 Barbara Correia. All rights reserved.
//

import UIKit

public class Bar: UIView {
    
    public var delegate: BarDelegate?
    
    public var animated = false
    public var selectedIndex: Int = 0 {
        didSet { updateSelection() }
    }
    public var layout = Layout() {
        didSet {
            updateLayout()
        }
    }
    
    public override var tintColor: UIColor! {
        didSet { updateColors() }
    }

    public private(set) var items: [Tab] = []
    
    private let constant = Constant()
    private var fonts: [UInt: UIFont] = [UIControl.State.normal.rawValue: UIFont.systemFont(ofSize: 12),
                                         UIControl.State.selected.rawValue: UIFont.systemFont(ofSize: 12, weight: .bold)]
    
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    private var stackView: UIStackView!
    private var lineView: UIView!
    private var itemLineView: UIView!
    
    public convenience init() {
        self.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    public func setFont(_ font: UIFont, for state: UIControl.State) {
        fonts[state.rawValue] = font
        controls.forEach { $0.setFont(font, for: state) }
    }
    
    public func add(item: Tab) {
        
        let view = createItem(item)
        stackView.addArrangedSubview(view)
        items.append(item)
    }
    
    public func add(items: [Tab]) {
        
        items.forEach { self.add(item: $0) }
        let currentIndex = selectedIndex
        layoutIfNeeded()
        selectedIndex = currentIndex
    }
    
    public func removeAll() {
        
        selectedIndex = 0
        
        items.removeAll()
        stackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
    }
}

// MARK: Action Methods

@objc private extension Bar {
    
    func itemTapped(_ sender: BarItem) {
        
        guard let index = controls.firstIndex(where: { $0 === sender }) else { return }
        delegate?.bar(self, willSelectIndex: index)
        selectedIndex = index
        delegate?.bar(self, didSelectIndex: index)
    }
}

// MARK: Support Methods

private extension Bar {
    
    var controls: [BarItem] {
        guard let stackView = self.stackView else { return [] }
        return stackView.arrangedSubviews.compactMap({ $0 as? BarItem })
    }
    
    func setup() {
        
        scrollViewSetup()
        stackViewSetup()
        lineSetup()
        
        constraintsSetup()
        
        tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    }
    
    func scrollViewSetup() {
        
        scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        addSubview(scrollView)
        
        contentView = UIView(frame: .zero)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
    }
    
    func stackViewSetup() {
        
        stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = layout.alignment
        stackView.spacing = layout.itemSpacing
        contentView.addSubview(stackView)
    }
    
    func lineSetup() {
        
        lineView = UIView(frame: .zero)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(lineView)
        
        itemLineView = UIView(frame: .zero)
        itemLineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.addSubview(itemLineView)
        
        itemLineView.isHidden = true
    }
    
    func constraintsSetup() {
        
        let contentViewWidthConstraint = contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        contentViewWidthConstraint.priority = UILayoutPriority.defaultLow
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            contentViewWidthConstraint,
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: layout.topSpacing, identifier: Constant.Constraint.stackViewTop.rawValue),
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, identifier: Constant.Constraint.stackViewCenterX.rawValue),
            lineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            lineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            lineView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: layout.bottomSpacing, identifier: Constant.Constraint.stackViewBottom.rawValue),
            itemLineView.heightAnchor.constraint(equalToConstant: layout.lineHeight, identifier: Constant.Constraint.lineHeight.rawValue),
            itemLineView.topAnchor.constraint(equalTo: lineView.topAnchor),
            itemLineView.bottomAnchor.constraint(equalTo: lineView.bottomAnchor),
            itemLineView.widthAnchor.constraint(equalToConstant: layout.itemWidth, identifier: Constant.Constraint.itemWidth.rawValue),
            itemLineView.leadingAnchor.constraint(equalTo: lineView.leadingAnchor, identifier: Constant.Constraint.itemLineLeading.rawValue)])
    }
    
    func createItem(_ tab: Tab) -> BarItem {
        
        let view = BarItem()
        view.widthAnchor.constraint(equalToConstant: layout.itemWidth, identifier: Constant.Constraint.itemWidth.rawValue).isActive = true
        
        view.addTarget(self, action: #selector(itemTapped(_:)), for: .touchUpInside)
        
        view.tintColor = tintColor
        view.image = tab.image
        view.title = tab.title
        
        fonts.forEach { view.setFont($1, for: UIControl.State(rawValue: $0)) }
        
        return view
    }
    
    func updateSelection() {
        
        guard !items.isEmpty else { return }
        guard selectedIndex >= 0,
            selectedIndex < items.count else {
                selectedIndex = 0
                return
        }
        
        controls.forEach { $0.isSelected = false }
        controls[selectedIndex].isSelected = true
        
        updateLineLayout()
    }
    
    func updateColors() {
        
        lineView.backgroundColor = tintColor.withAlphaComponent(constant.lineOpacity)
        itemLineView.backgroundColor = tintColor
        controls.forEach { $0.tintColor = tintColor }
    }
    
    func updateLayout() {
        
        var constraint = contentView.constraint(withIdentifier: Constant.Constraint.stackViewCenterX.rawValue)
        
        switch layout.alignment {
        case .leading:
            let identifier = Constant.Constraint.stackViewLeading.rawValue
            if contentView.constraint(withIdentifier: identifier) == nil {
                constraint = stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: layout.itemSpacing, identifier: identifier)
            }
        case .trailing:
            let identifier = Constant.Constraint.stackViewTrailing.rawValue
            if contentView.constraint(withIdentifier: identifier) == nil {
                constraint = stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: layout.itemSpacing, identifier: identifier)
            }
        default: break
        }
        
        contentView.constraint(withIdentifier: Constant.Constraint.stackViewCenterX.rawValue)?.isActive = false
        contentView.constraint(withIdentifier: Constant.Constraint.stackViewLeading.rawValue)?.isActive = false
        contentView.constraint(withIdentifier: Constant.Constraint.stackViewTrailing.rawValue)?.isActive = false
        
        constraint?.isActive = true
        constraint?.constant = layout.itemSpacing
        
        stackView.alignment = layout.alignment == .firstBaseline || layout.alignment == .lastBaseline ? .fill : layout.alignment
        stackView.spacing = layout.itemSpacing
        
        let stackViewTopConstraint = stackView.constraint(withIdentifier: Constant.Constraint.stackViewTop.rawValue)
        stackViewTopConstraint?.constant = layout.topSpacing
        let stackViewBottomConstraint = stackView.constraint(withIdentifier: Constant.Constraint.stackViewBottom.rawValue)
        stackViewBottomConstraint?.constant = layout.bottomSpacing
        let itemLineHeightConstraint = itemLineView.constraint(withIdentifier: Constant.Constraint.lineHeight.rawValue)
        itemLineHeightConstraint?.constant = layout.lineHeight
        let itemLineWidthConstraint = itemLineView.constraint(withIdentifier: Constant.Constraint.itemWidth.rawValue)
        itemLineWidthConstraint?.constant = layout.itemWidth
        
        controls.forEach {
            let constraint = $0.constraint(withIdentifier: Constant.Constraint.itemWidth.rawValue)
            constraint?.constant = layout.itemWidth
        }
        
        layoutIfNeeded()
    }
    
    func updateLineLayout() {
        
        itemLineView.isHidden = false
        
        let view = controls[selectedIndex]
        let rect = stackView.convert(view.frame, to: lineView)
        
        let lineLeadingConstraint = lineView.constraint(withIdentifier: Constant.Constraint.itemLineLeading.rawValue)
        lineLeadingConstraint?.constant = rect.origin.x
        
        if animated {
            UIView.animate(withDuration: 0.33) { [weak self] in
                self?.layoutIfNeeded()
            }
        } else {
            layoutIfNeeded()
        }
    }
}

// MARK: Models

public extension Bar {
    
    struct Tab {
        
        let image: UIImage?
        let title: String?
        
        public init(image: UIImage?, title: String?) {
            self.image = image
            self.title = title
        }
    }
    
    final class Layout {
        
        public var itemWidth: CGFloat = 70
        public var itemSpacing: CGFloat = 1
        public var lineHeight: CGFloat = 2
        public var topSpacing: CGFloat = 10
        public var bottomSpacing: CGFloat = 6
        
        public var alignment: UIStackView.Alignment = .fill
        
        public init() {}
    }
    
    private struct Constant {
        
        let lineOpacity: CGFloat = 0.4
        
        enum Constraint: String {
            case itemWidth
            case itemLineLeading
            case lineHeight
            case stackViewTop
            case stackViewBottom
            case stackViewLeading
            case stackViewTrailing
            case stackViewCenterX
        }
    }
}
