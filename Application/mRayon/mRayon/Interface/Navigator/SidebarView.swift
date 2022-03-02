//
//  SidebarView.swift
//  mRayon
//
//  Created by Lakr Aream on 2022/3/2.
//

import SwiftUI

struct SidebarView: View {
    var body: some View {
        NavigationView {
            sidebar
            WelcomeView()
        }
    }

    var sidebar: some View {
        List {
            Section("App") {
                NavigationLink {
                    WelcomeView()
                } label: {
                    Label("Quick Connect", systemImage: "paperplane")
                        .font(.system(.body, design: .rounded))
                }
                NavigationLink {
                    MachineView()
                } label: {
                    Label("Machine", systemImage: "server.rack")
                        .font(.system(.body, design: .rounded))
                }
                NavigationLink {
                    SnippetView()
                } label: {
                    Label("Snippet", systemImage: "chevron.left.forwardslash.chevron.right")
                        .font(.system(.body, design: .rounded))
                }
                NavigationLink {
                    IdentityView()
                } label: {
                    Label("Identity", systemImage: "person")
                        .font(.system(.body, design: .rounded))
                }
            }

            Section("Terminals") {
                NavigationLink {
                    TerminalTabView()
                } label: {
                    Label("No Session", systemImage: "square.dashed")
                        .font(.system(.body, design: .rounded))
                }
            }

            Section("Port Forward") {
                NavigationLink {
                    PortForwardTabView()
                } label: {
                    Label("No Session", systemImage: "square.dashed")
                        .font(.system(.body, design: .rounded))
                }
            }
        }
        .listStyle(SidebarListStyle())
        .navigationTitle("Rayon")
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView()
            .previewDevice(PreviewDevice(rawValue: "iPad mini (6th generation)"))
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
