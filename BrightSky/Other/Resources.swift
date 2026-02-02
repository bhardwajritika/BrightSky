//
//  Resources.swift
//  BrightSky
//
//  Created by Tarun Sharma on 30/01/26.
//

import Foundation


class Resources {
    func formatTemperature(temp: String) -> String {
        let number = temp
            .components(separatedBy: CharacterSet(charactersIn: "0123456789.").inverted)
            .joined()
        
        let value = Double(number) ?? 0
        let formatted = String(format: "%.2f°C", locale: Locale(identifier: "en_US_POSIX"), value)
        
        return formatted
    }
}

