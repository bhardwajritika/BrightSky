//
//  CurrentWeatherView.swift
//  BrightSky
//
//  Created by Tarun Sharma on 09/01/26.
//

import UIKit

final class CurrentWeatherView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemOrange
        translatesAutoresizingMaskIntoConstraints = false 
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
