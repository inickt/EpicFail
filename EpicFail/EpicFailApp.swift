//
//  EpicFailApp.swift
//  EpicFail
//
//  Created by Nick Thompson on 12/7/23.
//

import SwiftUI

@main
struct EpicFailApp: App {
    private let maps: Maps = {
        return try! JSONDecoder().decode(
            Maps.self,
            from: Data(contentsOf: Bundle.main.url(forResource: "combined", withExtension: "json")!)
        )
    }()

    var body: some Scene {
        WindowGroup {
            MapView(map: maps.first(where: { $0.mapName.contains("Wildcat")} )!)
        }
    }
}
