//
//  RayonStore.swift
//  Rayon
//
//  Created by Lakr Aream on 2022/2/8.
//

import NSRemoteShell
import PropertyWrapper

public class RayonStore: ObservableObject {
    public init() {
        defer {
            debugPrint("RayonStore initialer completed")
        }

        licenseAgreed = UserDefaults
            .standard
            .value(
                forKey: UserDefaultKey.licenseAgreed.rawValue
            ) as? Bool ?? false
        storeRecent = UDStoreRecent
        saveTemporarySession = UDSaveTemporarySession

        if let read = readEncryptedDefault(
            from: .userIdentitiesEncrypted,
            userIdentities.self
        ) {
            userIdentities = read
        }
        if let read = readEncryptedDefault(
            from: .remoteMachinesEncrypted,
            remoteMachines.self
        ) {
            remoteMachines = read
        }
        if let read = readEncryptedDefault(
            from: .remoteMachineRedactedLevel,
            remoteMachineRedactedLevel.self
        ) {
            remoteMachineRedactedLevel = read
        }
        if let read = readEncryptedDefault(
            from: .userSnippetsEncrypted,
            userSnippets.self
        ) {
            userSnippets = read
        }
        if let read = readEncryptedDefault(
            from: .recentRecordEncrypted,
            recentRecord.self
        ) {
            recentRecord = read
        }
    }

    public static let shared = RayonStore()

    @Published public var licenseAgreed: Bool = false {
        didSet {
            storeDefault(to: .licenseAgreed, with: licenseAgreed)
        }
    }

    @Published public var globalProgressInPresent: Bool = false
    var globalProgressCount: Int = 0 {
        didSet {
            if globalProgressCount == 0 {
                globalProgressInPresent = false
            } else {
                globalProgressInPresent = true
            }
        }
    }

    @Published public var userIdentities: RDIdentityGroup = .init() {
        didSet {
            storeEncryptedDefault(
                to: .userIdentitiesEncrypted,
                with: userIdentities
            )
        }
    }

    public var userIdentitiesForAutoAuth: [RDIdentity] {
        userIdentities
            .identities
            .filter(\.authenticAutomatically)
            // make sure not to reopen too many times
            .sorted { $0.username < $1.username }
    }

    @Published public var remoteMachineRedactedLevel: RDMachine.RedactedLevel = .none {
        didSet {
            storeEncryptedDefault(
                to: .remoteMachineRedactedLevel,
                with: remoteMachineRedactedLevel
            )
        }
    }

    @Published public var remoteMachines: RDMachineGroup = .init() {
        didSet {
            storeEncryptedDefault(
                to: .remoteMachinesEncrypted,
                with: remoteMachines
            )
        }
    }

    @UserDefaultsWrapper(key: "wiki.qaq.rayon.saveTemporarySession", defaultValue: true)
    private var UDSaveTemporarySession: Bool

    @Published public var saveTemporarySession: Bool = false {
        didSet {
            UDSaveTemporarySession = saveTemporarySession
        }
    }

    @UserDefaultsWrapper(key: "wiki.qaq.rayon.storeRecent", defaultValue: true)
    private var UDStoreRecent: Bool

    @Published public var storeRecent: Bool = false {
        didSet {
            UDStoreRecent = storeRecent
            if !storeRecent {
                recentRecord = []
            }
        }
    }

    @UserDefaultsWrapper(key: "wiki.qaq.rayon.maxRecentRecordCount", defaultValue: 8)
    public var maxRecentRecordCount: Int

    @Published public var recentRecord: [RecentConnection] = [] {
        didSet {
            storeEncryptedDefault(
                to: .recentRecordEncrypted,
                with: recentRecord
            )
        }
    }

    @Published public var userSnippets: RDSnippetGroup = .init() {
        didSet {
            storeEncryptedDefault(
                to: .userSnippetsEncrypted,
                with: userSnippets
            )
        }
    }

    @Published public var remoteSessions: [RDSession] = []
}
