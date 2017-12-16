//
//  Theme.swift
//  Concentration
//
//  Created by Miretz Dev on 16/12/2017.
//  Copyright © 2017 Miretz. All rights reserved.
//

import Foundation

enum Theme: String, CustomStringConvertible {
    
    var description: String { return rawValue }
    
    case halloween = "🧟‍♀️🧛‍♀️🧛‍♂️🧟‍♂️🤡👺🦇🎃👻🧙‍♂️👹👽🙀💀🧝‍♀️🧚‍♀️🧞‍♂️🧜‍♀️🤖👾"
    case devices = "⌚️📱💻⌨️🖥🖨🕹💽💾📷📹📽📞☎️📟📠📺⏰🕰🔦🔭🔬"
    case food = "🍎🍐🍊🍋🍌🍉🍇🍓🍈🍒🍑🍍🥝🍅🌶🥐🥨🍞🥖🍳🌭🍔🍟🌮🥙🍕🧀🍭🍩🍿"
    case emojis = "😀😆😅😂😇😊😍😘😋🤪😛🧐🤓😎😳🤔😴🤤😬🤑🤠😮"
    case sports = "⚽️🏀🏈⚾️🎾🏐🏉🎱🏓🏸🏒⛳️🏹⛸🛷🏂⛷🏆🚴‍♀️🧗‍♀️🚣‍♂️🏊‍♀️🧘‍♀️🏌️‍♀️"
    case people = "👲🧕👮‍♀️💂‍♀️👷‍♂️🕵️‍♀️👩‍🌾👩‍⚕️👨‍🍳👩‍🎓👨‍🎓👩‍🎤👨‍🎤👨‍🏭👩‍💻👩‍💼👩‍🎨👨‍🚒👨‍🔬🤵🎅👨‍💼👳‍♀️👵👴🏽"
    case animals = "🐶🐱🐭🐹🐰🦊🐻🐼🐨🐯🦁🐮🐷🐸🐵🐔🐧🐦🐤🦉🐝🐞🦋🐌🐡"
    case flags = "🏳️‍🌈🇦🇫🇦🇽🇦🇱🇩🇿🇦🇸🇦🇩🇦🇷🇦🇲🇦🇼🇦🇺🇦🇹🇨🇿🇩🇰🇪🇺🇩🇪🇬🇷🇸🇰🇸🇮🇷🇸🇰🇷🇷🇺🇬🇧🇺🇸🇻🇳🇹🇷🇪🇸🇨🇭🇯🇵🇮🇩🇮🇱🇫🇮🇪🇪"
    
    static var all = [Theme.halloween, .devices, .food, .emojis, .sports, .people, .animals, .flags]

    static func randomTheme() -> Theme {
        let randomIndex = all.count.arc4random
        return all[randomIndex]
    }
    
}
