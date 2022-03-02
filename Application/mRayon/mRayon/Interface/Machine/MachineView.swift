//
//  MachineView.swift
//  mRayon
//
//  Created by Lakr Aream on 2022/3/2.
//

import RayonModule
import SwiftUI

struct MachineView: View {
    @EnvironmentObject var store: RayonStore

    var body: some View {
        Group {
            if store.machineGroup.machines.isEmpty {
                PlaceholderView("No Machine Available", img: .emptyWindow)
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {}
                }
            }
        }
        .navigationTitle("Machine")
        .toolbar {
            ToolbarItem {
                Button {} label: {
                    Label("Create Machine", systemImage: "plus")
                }
            }
        }
    }
}

struct MachineView_Previews: PreviewProvider {
    static var previews: some View {
        createPreview {
            AnyView(MachineView())
        }
    }
}
