import XCTest

import JSONAPIArbitraryTests

var tests = [XCTestCaseEntry]()
tests += JSONAPIArbitraryTests.allTests()
XCTMain(tests)