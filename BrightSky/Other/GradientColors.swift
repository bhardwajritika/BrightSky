//
//  GradientColors.swift
//  BrightSky
//
//  Created by Tarun Sharma on 19/03/26.
//

import Foundation
import UIKit

 func getGradientColors() -> (topColor: UIColor, bottomColor: UIColor) {
    let hour = Calendar.current.component(.hour, from: Date())
    
    switch hour {
    case 5..<7:
        return (
            UIColor(red: 0.92, green: 0.48, blue: 0.30, alpha: 1),
            UIColor(red: 0.35, green: 0.30, blue: 0.72, alpha: 1)
        )
        
    case 7..<12:
        return (
            UIColor(red: 0.16, green: 0.48, blue: 0.89, alpha: 1),
            UIColor(red: 0.42, green: 0.70, blue: 0.96, alpha: 1)
        )
        
    case 12..<17:
        return (
            UIColor(red: 0.07, green: 0.36, blue: 0.84, alpha: 1),
            UIColor(red: 0.20, green: 0.56, blue: 0.92, alpha: 1)
        )
        
    case 17..<20:
        return (
            UIColor(red: 0.82, green: 0.33, blue: 0.14, alpha: 1),
            UIColor(red: 0.22, green: 0.10, blue: 0.44, alpha: 1)
        )
        
    default:
        return (
            UIColor(red: 0.04, green: 0.08, blue: 0.24, alpha: 1),
            UIColor(red: 0.08, green: 0.04, blue: 0.16, alpha: 1)
        )
    }
}

