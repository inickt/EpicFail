//
//  MapView.swift
//  EpicFail
//
//  Created by Nick Thompson on 12/7/23.
//

import SwiftUI

struct MapView: View {

    @State private var showClosed: Bool = true

    let map: Map

    var body: some View {
        VStack {
            Text(map.mapName)
            Toggle(isOn: $showClosed) {
                Text("Show all  trails")
            }
            AsyncImage(
                url: URL(string: map.imageData.url + "?$JPG_oneToOne$"),
                content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .overlay(
                            ZStack {
                                ForEach(
                                    map.trails.filter { showClosed || $0.data.openingStatus != .closed }
                                ) { trail in
                                    TrailView(trail: trail)
                                }
                            }
                        )
                },
                placeholder: {
                    ProgressView()
                }
            )
            EmptyView()
        }
    }
}

struct TrailView: View {
    private struct RelativePath: Shape {
        let points: [(Double, Double)]

        func path(in rect: CGRect) -> SwiftUI.Path {
            SwiftUI.Path { path in
                func fromRelative(x: Double, y: Double) -> CGPoint {
                    return CGPoint(
                        x: rect.size.width * x,
                        y: rect.size.height * y
                    )
                }
                if let point = points.first {
                    path.move(to: fromRelative(x: point.0, y: point.1))
                }

                for point in points.dropFirst() {
                    path.addLine(to: fromRelative(x: point.0, y: point.1))
                }
            }
        }
    }

    let trail: Trail

    var body: some View {
        if let path = trail.data.paths?.first {
            RelativePath(points: path.points.map { ($0.x, $0.y) })
                .stroke(color, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                .onTapGesture {
                    print(trail.data.name)
                }
        }
    }

    private var color: Color {
        switch trail.data.trailLevel {
        case .greenCircle: .green
        case .blueSquare: .blue
        case .blackDiamond: .black
        case .doubleBlackDiamond: .black
        case .terrainParks: .orange
        }
    }
}


//#Preview {
//    MapView()
//}
