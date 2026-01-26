//
//  SettingsViewModel.swift
//  BrightSky
//
//  Created by Tarun Sharma on 26/01/26.
//

import Foundation

struct SettingsViewModel {
    let options : [SettingOption]
}

enum SettingOption : String , CaseIterable {
    case upgrade
    case privacyPolicy
    case terms
    case contact
    case getHelp
    case rateApp
    
    
    var title: String {
        switch self {
        case .upgrade:
            "Upgrade"
        case .privacyPolicy:
            "Privacy Policy"
        case .terms:
            "Terms of Use"
        case .contact:
            "Contact Us"
        case .getHelp:
            "Get Help"
        case .rateApp:
            "Rate App"
        }
    }
}
