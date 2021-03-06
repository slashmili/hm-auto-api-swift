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
//  ValetMode.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 12/12/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import Foundation


public struct ValetMode: FullStandardCommand {

    public let state: ActiveState?


    // MARK: FullStandardCommand

    public let properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        state = properties.value(for: 0x01)

        // Properties
        self.properties = properties
    }
}

extension ValetMode: Identifiable {

    public static var identifier: Identifier = Identifier(0x0028)
}

extension ValetMode: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesType {

        case getValetMode                   = 0x00
        case valetMode                      = 0x01
        case activateDeactivateValetMode    = 0x02


        public static let getState = MessageTypes.getValetMode
        public static let state = MessageTypes.valetMode

        public static var all: [UInt8] {
            return [self.getValetMode.rawValue,
                    self.valetMode.rawValue,
                    self.activateDeactivateValetMode.rawValue]
        }
    }
}

public extension ValetMode {

    static var activateValetMode: (ActiveState) -> [UInt8] {
        return {
            return identifier.bytes + [0x02, $0.rawValue]
        }
    }

    static var getValetMode: [UInt8] {
        return getState
    }
}
