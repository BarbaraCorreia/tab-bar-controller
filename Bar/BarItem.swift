//
//  BarItem.swift
//  Bar
//
//  Created by Barbara Correia on 23/04/2019.
//  Copyright © 2019 Barbara Correia. All rights reserved.
//

import UIKit

class BarItem: UIControl {
    
    var image: UIImage? {
        didSet { imageView.image = image?.withRenderingMode(.alwaysTemplate) }
    }
    var title: String? {
        didSet { titleLabel.text = title }
    }
    
    override var isSelected: Bool {
        didSet {
            updateColors()
            updateFonts()
        }
    }
    
    public override var tintColor: UIColor! {
        didSet { updateColors() }
    }
    
    private let constant = Constant()
    private var fonts: [UInt: UIFont] = [UIControl.State.normal.rawValue: UIFont.systemFont(ofSize: 12),
                                         UIControl.State.selected.rawValue: UIFont.systemFont(ofSize: 12, weight: .bold)]
    
    private var imageView: UIImageView!
    private var titleLabel: UILabel!
    
    convenience init() {
        self.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setFont(_ font: UIFont, for state: UIControl.State) {
        fonts[state.rawValue] = font
        #warning("Improve this method")
        updateFonts()
    }
}

private extension BarItem {
    
    func setup() {
        
        imageView = UIImageView()
        imageView.contentMode = .center
        imageView.tintColor = tintColor
        [imageView.widthAnchor, imageView.heightAnchor].forEach {
            $0.constraint(equalToConstant: constant.imageWidth).isActive = true
        }
        
        titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = constant.maxNumberOfLines
        titleLabel.textColor = tintColor
        
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.isUserInteractionEnabled = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)])
        
        isSelected = false
    }
    
    func updateColors() {
        
        let color = isSelected ? tintColor : tintColor.withAlphaComponent(constant.unselectedOpacity)
        imageView.tintColor = color
        titleLabel.textColor = color
    }
    
    func updateFonts() {
        
        let state: UIControl.State = isSelected ? .selected : .normal
        titleLabel.font = fonts[state.rawValue]
    }
}

private extension BarItem {
    
    struct Constant {
        
        let imageWidth: CGFloat = 32
        let unselectedOpacity: CGFloat = 0.7
        let maxNumberOfLines = 2
    }
}
