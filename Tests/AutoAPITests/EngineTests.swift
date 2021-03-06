//
// AutoAPITests
// Copyright (C) 2017 High-Mobility GmbH
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program. If not, see http://www.gnu.org/licenses/.
//
// Please inquire about commercial licensing options at
// licensing@high-mobility.com
//
//
//  EngineTests.swift
//  AutoAPITests
//
//  Created by Mikk Rätsep on 28/11/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import AutoAPI
import XCTest


class EngineTests: XCTestCase {

    static var allTests = [("testGetState", testGetState),
                           ("testState", testState),
                           ("testTurnEngine", testTurnEngine)]


    // MARK: XCTestCase

    func testGetState() {
        let bytes: [UInt8] = [
            0x00, 0x35, // MSB, LSB Message Identifier for Engine
            0x00        // Message Type for Get Ignition State
        ]

        XCTAssertEqual(Engine.getState, bytes)
    }

    func testState() {
        let bytes: [UInt8] = [
            0x00, 0x35, // MSB, LSB Message Identifier for Engine
            0x01,       // Message Type for Ignition State

            0x01,       // Property Identifier for Ignition
            0x00, 0x01, // Property size 1 byte
            0x01        // Engine On
        ]

        guard let engine = AutoAPI.parseBinary(bytes) as? Engine else {
            return XCTFail("Parsed value is not Engine")
        }

        XCTAssertEqual(engine.ignition, .engineOn)
    }

    func testTurnEngine() {
        let bytes: [UInt8] = [
            0x00, 0x35, // MSB, LSB Message Identifier for Engine
            0x02,       // Message Type for Turn Engine On/Off
            0x01        // Engine On
        ]

        XCTAssertEqual(Engine.turnIgnition(.engineOn), bytes)
    }
}
