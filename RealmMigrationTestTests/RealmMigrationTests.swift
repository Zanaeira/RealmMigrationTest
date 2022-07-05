//
//  RealmMigrationTests.swift
//  RealmMigrationTests
//
//  Created by Suhayl Ahmed on 05/07/2022.
//

import XCTest
import RealmSwift

class RealmMigrationTests: XCTestCase {

    override func setUp() {
        super.setUp()

        setupEmptyStoreState()
    }

    override func tearDown() {
        super.tearDown()

        setupEmptyStoreState()
    }

    func test_canGetCurrentSchemaVersionAtURL() {
        guard let fileUrl = getFileUrl() else {
            return XCTFail("Could not find file")
        }

        print(fileUrl)

        var currentSchemaVersion: UInt64?

        do {
            currentSchemaVersion = try schemaVersionAtURL(fileUrl)
        } catch {
            return XCTFail("Realm currentSchemaVersion Error: \(error)")
        }
    }

}

private extension RealmMigrationTests {
    // MARK: - Helpers
    private func getFileUrl() -> URL? {
        return Realm.Configuration.defaultConfiguration.fileURL!.deletingLastPathComponent().appendingPathComponent("\(type(of: self)).realm")
    }

    private func getTestStoreConfig() -> Realm.Configuration {
        var config = Realm.Configuration.defaultConfiguration
        config.fileURL = getFileUrl()

        return config
    }

    private func setupEmptyStoreState() {
        let config = getTestStoreConfig()
        guard let fileURL = config.fileURL else { return }

        try? FileManager.default.removeItem(at: fileURL)
    }
}
