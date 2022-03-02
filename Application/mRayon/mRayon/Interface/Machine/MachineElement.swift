//
//  MachineElement.swift
//  mRayon
//
//  Created by Lakr Aream on 2022/3/2.
//

import RayonModule
import SwiftUI

struct MachineElementView: View {
    let machine: RDMachine.ID

    @EnvironmentObject var store: RayonStore
    let redactedColor: Color = .green

    var body: some View {
        contentView
            .contextMenu {
                Button {
                    let index = store
                        .machineGroup
                        .machines
                        .firstIndex { $0.id == machine }
                    if let index = index {
                        store.machineGroup.machines.remove(at: index)
                    }
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
    }

    var contentView: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Image(systemName: "server.rack")
                HStack {
                    Text(store.machineGroup[machine].name)
                    Spacer()
                }
                .overlay(
                    Rectangle()
                        .cornerRadius(2)
                        .foregroundColor(redactedColor)
                        .expended()
                        .opacity(
                            store.machineRedacted.rawValue > 1 ? 1 : 0
                        )
                )
            }
            .font(.system(.headline, design: .rounded))
            HStack {
                Text(store.machineGroup[machine].remoteAddress)
                Spacer()
                Text(store.machineGroup[machine].remotePort)
                    .frame(width: 50)
            }
            .overlay(
                Rectangle()
                    .cornerRadius(2)
                    .foregroundColor(redactedColor)
                    .expended()
                    .opacity(
                        store.machineRedacted.rawValue > 0 ? 1 : 0
                    )
            )
            .font(.system(.subheadline, design: .rounded))
            Divider()
            HStack(spacing: 4) {
                VStack(alignment: .trailing, spacing: 5) {
                    Text("Activity:")
                        .lineLimit(1)
                    Text("Banner:")
                        .lineLimit(1)
                    Text("Comment:")
                        .lineLimit(1)
                }
                VStack(alignment: .leading, spacing: 5) {
                    Text(
                        store.machineGroup[machine]
                            .lastConnection
                            .formatted(date: .abbreviated, time: .omitted)
                    )
                    .lineLimit(1)
                    Text(
                        store.machineGroup[machine]
                            .lastBanner
                            .count > 0 ?
                            store.machineGroup[machine].lastBanner
                            : "Not Identified"
                    )
                    .lineLimit(1)
                    Text(
                        store.machineGroup[machine]
                            .comment
                            .count > 0 ?
                            store.machineGroup[machine].comment
                            : "No Comment"
                    )
                    .lineLimit(1)
                }
            }
            .font(.system(.caption, design: .rounded))
            .overlay(
                Rectangle()
                    .cornerRadius(2)
                    .foregroundColor(redactedColor)
                    .expended()
                    .opacity(
                        store.machineRedacted.rawValue > 1 ? 1 : 0
                    )
            )
            Divider()
            Text(machine.uuidString)
                .textSelection(.enabled)
                .font(.system(size: 5, weight: .light, design: .monospaced))
        }
        .animation(.interactiveSpring(), value: store.machineRedacted)
        .frame(maxWidth: .infinity)
    }
}

struct MachineElementView_Previews: PreviewProvider {
    static var previews: some View {
        MachineElementView(machine: UUID())
            .environmentObject(RayonStore.shared)
    }
}
