//
//  View.swift
//  mRayon
//
//  Created by Lakr Aream on 2022/3/2.
//

import SwiftUI

extension View {
    func expended() -> some View {
        frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    func roundedCorner() -> some View {
        cornerRadius(8)
    }
}

import RayonModule

func createPreview(creation: () -> AnyView) -> some View {
    Group {
        NavigationView {
            creation()
                .environmentObject(RayonStore.shared)
        }
        .previewDevice(PreviewDevice(rawValue: "iPod touch (7th generation)"))
        .navigationViewStyle(StackNavigationViewStyle())
        NavigationView {
            NavigationLink(isActive: .constant(true)) {
                creation()
                    .environmentObject(RayonStore.shared)
            } label: {
                Label("Preview Layout", systemImage: "arrow.right")
            }
        }
        .previewDevice(PreviewDevice(rawValue: "iPad mini (6th generation)"))
        .previewInterfaceOrientation(.landscapeLeft)
    }
}
