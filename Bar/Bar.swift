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
    public var selectedIndex: Int = 0 {
        didSet { updateSelection() }
    }
    
    public override var tintColor: UIColor! {
        didSet { updateColors() }
    }

    public private(set) var items: [Tab] = []
    
    private let constant = Constant()
    private var fonts: [UInt: UIFont] = [UIControl.State.normal.rawValue: UIFont.systemFont(ofSize: 12),
                                         UIControl.State.selected.rawValue: UIFont.systemFont(ofSize: 12)]
    
    private var stackView: UIStackView!
    private var lineView: UIView!
    
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
        
        items.append(item)
        let view = createItem(item)
        stackView.addArrangedSubview(view)
    }
    
    public func add(items: [Tab]) {
        items.forEach { self.add(item: $0) }
    }
}

// MARK: Action Methods

@objc private extension Bar {
    
    func itemTapped(_ sender: BarItem) {
        
        guard let index = controls.firstIndex(where: { $0 == sender }) else { return }
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
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            lineView.heightAnchor.constraint(equalToConstant: layout.lineHeight),
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor)])
        
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
        
        guard selectedIndex >= 0,
            selectedIndex < items.count else {
                selectedIndex = 0
                return
        }
        
        controls.forEach { $0.isSelected = false }
        controls[selectedIndex].isSelected = true
    }
    
    func updateColors() {
        
        lineView.backgroundColor = tintColor.withAlphaComponent(constant.lineOpacity)
        controls.forEach { $0.tintColor = tintColor }
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
    }
    
    private struct Constant {
        let lineOpacity: CGFloat = 0.4
    }
}
