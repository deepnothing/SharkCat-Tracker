//
//  AppIntent.swift
//  SharkCatWidget
//
//  Created by Teo on 12/16/24.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource { "Configuration" }
    static var description: IntentDescription { "SC Tracker." }

    // An example configurable parameter.
    @Parameter(title: "Favorite Emoji", default: "🦈 🐱")
    var favoriteEmoji: String
}
