//
//  File.swift
//  CustomFrameworks
//
//  Created by G on 21.12.2022.
//

import UIKit

open class CustomUIView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
