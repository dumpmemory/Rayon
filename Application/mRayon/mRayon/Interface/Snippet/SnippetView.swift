//
//  SnippetView.swift
//  mRayon
//
//  Created by Lakr Aream on 2022/3/2.
//

import RayonModule
import SwiftUI

struct SnippetView: View {
    @EnvironmentObject var store: RayonStore

    var body: some View {
        Group {
            if store.identityGroup.identities.isEmpty {
                PlaceholderView("No Snippet Available", img: .ghost)
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {}
                }
            }
        }
        .navigationTitle("Snippet")
        .toolbar {
            ToolbarItem {
                Button {} label: {
                    Label("Create Snippet", systemImage: "plus")
                }
            }
        }
    }
}

struct SnippetView_Previews: PreviewProvider {
    static var previews: some View {
        createPreview {
            AnyView(SnippetView())
        }
    }
}
