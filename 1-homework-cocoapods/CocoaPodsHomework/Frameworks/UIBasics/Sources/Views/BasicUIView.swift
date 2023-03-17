//
//  File.swift
//  UIBasics
//
//  Created by G on 20.12.2022.
//

import UIKit

open class BasicUIView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
