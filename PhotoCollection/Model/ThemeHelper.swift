//
//  ThemeHelper.swift
//  PhotoCollection
//
//  Created by Stephanie Ballard on 8/3/20.
//  Copyright © 2020 Stephanie Ballard. All rights reserved.
//

import Foundation

extension String {
    static var themePreferenceKey: String = "Theme Preference"
}

class ThemeHelper {
    
    init() {
        if themePreference == nil {
            setThemePreferenceToDark()
        }
    }
    
    var themePreference: String? {
        return UserDefaults.standard.string(forKey: .themePreferenceKey)
    }
    
    func setThemePreferenceToDark() {
        UserDefaults.standard.set("Dark", forKey: .themePreferenceKey)
    }
    
    func setThemePreferenceToPink() {
        UserDefaults.standard.set("Pink", forKey: .themePreferenceKey)
    }
}
