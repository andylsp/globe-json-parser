//
//  UseCaseTests.swift
//  globe-json-parserTests
//
//  Created by Jonathan Andy Lim on 5/11/25.
//

import XCTest
@testable import globe_json_parser

final class UseCaseTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDownloadItemsFromAPI() async {
        let result = await GetItemsFromAPIUseCase().invoke()
        XCTAssertGreaterThan(result.count, 0, "result must be greater than 0.")
    }

}
