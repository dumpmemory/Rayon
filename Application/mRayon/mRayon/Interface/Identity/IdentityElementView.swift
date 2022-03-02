//
//  IdentityElementView.swift
//  mRayon
//
//  Created by Lakr Aream on 2022/3/2.
//

import RayonModule
import SwiftUI

struct IdentityElementView: View {
    @EnvironmentObject var store: RayonStore

    let identity: RDIdentity.ID

    @State var openEdit: Bool = false

    var recentDate: String {
        if store
            .identityGroup[identity]
            .lastRecentUsed
            .timeIntervalSince1970 == 0
        {
            return "Never"
        }
        return store
            .identityGroup[identity]
            .lastRecentUsed
            .formatted()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(store.identityGroup[identity].username)
                    .font(.system(.title2, design: .rounded))
                    .bold()
                Spacer()
                if store.identityGroup[identity].authenticAutomatically {
                    Image(systemName: "a.circle.fill")
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundColor(.accentColor)
                }
            }
            Divider()
            Text(store.identityGroup[identity].shortDescription())
                .font(.system(.subheadline, design: .rounded))
            Text("Recent Activity: " + recentDate)
                .font(.system(.subheadline, design: .rounded))
            Divider()
            Text(identity.uuidString)
                .font(.system(size: 8, weight: .light, design: .rounded))
        }
        .padding()
        .background(
            Color.accentColor
                .opacity(0.1)
                .roundedCorner()
        )
        .background(
            NavigationLink(isActive: $openEdit) {
                EditIdentityView { identity }
            } label: {
                Group {}
            }
        )
        .contextMenu {
            Button {
                openEdit = true
            } label: {
                Label("Edit", systemImage: "pencil")
            }
            Button {
                delete()
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }

    func delete() {
        UIBridge.requiresConfirmation(
            message: "Are you sure you want to delete this identity?"
        ) { confirmed in
            if confirmed {
                let index = store
                    .identityGroup
                    .identities
                    .firstIndex { $0.id == identity }
                if let index = index {
                    store.identityGroup.identities.remove(at: index)
                }
            }
        }
    }
}

struct IdentityElementView_Previews: PreviewProvider {
    static var identity: UUID {
        let id = UUID(uuidString: "43A18BB5-3986-44C1-812C-0D012233FE56")!
//        var read = RayonStore.shared.identityGroup[id]
//        read.username = "root"
//        read.password = "alpine"
//        read.publicKey = "aaa"
//        read.privateKey = "bbb"
//        read.authenticAutomatically = true
//        read.comment = "xxxxxx"
        ////        read.group = ""
//        RayonStore.shared.identityGroup[id] = read
        return id
    }

    static var previews: some View {
        IdentityElementView(identity: identity)
            .environmentObject(RayonStore.shared)
            .previewLayout(.fixed(width: 500, height: 150))
    }
}
