//
// AutoAPI
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
//  Door.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 29/11/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import Foundation


public struct Door: Item {

    public typealias Location = Position


    public let location: Location
    public let lock: LockState
    public let position: PositionState


    // MARK: Item

    static let size: Int = 3
}

extension Door: BinaryInitable {

    init?(bytes: [UInt8]) {
        guard let location = Location(rawValue: bytes[0]),
            let position = PositionState(rawValue: bytes[1]),
            let lock = LockState(rawValue: bytes[2]) else {
                return nil
        }

        self.location = location
        self.lock = lock
        self.position = position
    }
}
