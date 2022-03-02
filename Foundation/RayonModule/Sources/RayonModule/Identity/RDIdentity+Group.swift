//
//  RDIdentity.swift
//  Rayon
//
//  Created by Lakr Aream on 2022/2/9.
//

import Foundation
import NSRemoteShell

public struct RDIdentityGroup: Codable, Identifiable {
    public typealias AssociatedType = RDIdentity

    public var id = UUID()

    public var identities: [AssociatedType] = []

    public var count: Int {
        identities.count
    }

    public mutating func insert(_ value: AssociatedType) {
        if let index = identities.firstIndex(where: { $0.id == value.id }) {
            identities[index] = value
        } else {
            identities.append(value)
        }
    }

    public subscript(_ id: AssociatedType.ID) -> AssociatedType {
        get {
            identities.first(where: { $0.id == id }) ?? .init()
        }

        set(newValue) {
            if let index = identities.firstIndex(where: { $0.id == newValue.id }) {
                identities[index] = newValue
            } else {
                identities.append(newValue)
            }
        }
    }
}
