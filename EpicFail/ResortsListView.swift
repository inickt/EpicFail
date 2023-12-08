//
//  ResortsListView.swift
//  EpicFail
//
//  Created by Nick Thompson on 12/7/23.
//

import SwiftUI

struct ResortsListView: View {
    @State private var resorts: Resorts = []

    var body: some View {
        List(resorts) { resort in
            NavigationLink(resort.displayName + " (\(resort.id))", value: resort)
        }
        .navigationDestination(for: Resort.self, destination: ResortView.init)
        .navigationTitle("Resorts")
        .task {
            do {
                let url = URL(string: "https://api-az.vailresorts.com/digital/uiservice/api/v1/resorts")!
                let (data, _) = try await URLSession.shared.data(from: url)
                resorts = try JSONDecoder().decode(Resorts.self, from: data)
            } catch {
                print(error)
            }
        }
    }
}
