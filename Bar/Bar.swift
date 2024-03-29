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
    
    public var layout = Layout()
    public var animated = false
    public var selectedIndex: Int = 0 {
        didSet { updateSelection() }
    }
    
    public override var tintColor: UIColor! {
        didSet { updateColors() }
    }

    public private(set) var items: [Tab] = []
    
    private let constant = Constant()
    private var fonts: [UInt: UIFont] = [UIControl.State.normal.rawValue: UIFont.systemFont(ofSize: 12),
                                         UIControl.State.selected.rawValue: UIFont.systemFont(ofSize: 12, weight: .bold)]
    
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
        
        stackViewSetup()
        lineSetup()
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: layout.topSpacing),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            lineView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: layout.bottomSpacing),
            itemLineView.heightAnchor.constraint(equalToConstant: layout.lineHeight),
            itemLineView.topAnchor.constraint(equalTo: lineView.topAnchor),
            itemLineView.bottomAnchor.constraint(equalTo: lineView.bottomAnchor),
            itemLineView.widthAnchor.constraint(equalToConstant: layout.itemWidth),
            itemLineView.leadingAnchor.constraint(equalTo: lineView.leadingAnchor, identifier: Constant.Constraint.itemLineLeading.rawValue)])
        
        tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    }
    
    func stackViewSetup() {
        
        stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = layout.itemSpacing
        addSubview(stackView)
    }
    
    func lineSetup() {
        
        lineView = UIView(frame: .zero)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(lineView)
        
        itemLineView = UIView(frame: .zero)
        itemLineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.addSubview(itemLineView)
        
        itemLineView.isHidden = true
    }
    
    func createItem(_ tab: Tab) -> BarItem {
        
        let view = BarItem()
        view.widthAnchor.constraint(equalToConstant: layout.itemWidth).isActive = true
        
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
        
        var itemWidth: CGFloat = 70
        var itemSpacing: CGFloat = 1
        var lineHeight: CGFloat = 2
        var topSpacing: CGFloat = 10
        var bottomSpacing: CGFloat = 6
    }
    
    private struct Constant {
        
        let lineOpacity: CGFloat = 0.4
        
        enum Constraint: String {
            case itemLineLeading
        }
    }
}
