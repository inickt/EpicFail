//
//  ResortView.swift
//  EpicFail
//
//  Created by Nick Thompson on 12/7/23.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort
    @State private var maps: Maps = []
    @State private var selectedMap: Map?

    var body: some View {
        VStack {
            if let map = selectedMap {
                MapView(map: map)
            }
        }
        .toolbar {
            if maps.count > 1 {
                Picker("", selection: $selectedMap) {
                    ForEach(maps) { map in
                        Text(map.mapName).tag(map as Map?)
                    }
                }
            }
        }
        .navigationTitle(resort.displayName)
        .task {
            do {
                let url = URL(string: "https://api-az.vailresorts.com/digital/uiservice/api/v1/resorts/\(resort.id)/maps")!
                var request = URLRequest(url: url)
                request.setValue("acd8be1a83f441dbb9dfa5a598a1f6d2", forHTTPHeaderField: "client_id")
                request.setValue("DDC5a7ccC7534c909bE5e1726ed0B8bf", forHTTPHeaderField: "client_secret")
                let (data, _) = try await URLSession.shared.data(for: request)
                maps = try JSONDecoder().decode(Maps.self, from: data)
                if let primary = maps.first(where: { $0.mapName == resort.primaryMap.name }) {
                    selectedMap = primary
                } else {
                    selectedMap = maps.first
                }
            } catch {
                print(error)
            }
        }
    }
}
