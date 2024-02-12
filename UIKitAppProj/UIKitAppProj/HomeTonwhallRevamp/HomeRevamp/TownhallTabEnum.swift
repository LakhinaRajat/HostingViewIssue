//
//  TownhallTabEnum.swift
//  Gutrgoo
//
//  Created by Rajat Lakhina on 06/02/24.
//

import Foundation

enum TownhallTab: CaseIterable {
    case timeline
    case aniNews
    
    var title: String {
        switch self {
            case .timeline:
                return "timeline"
            case .aniNews:
                return "news"
        }
    }
}
