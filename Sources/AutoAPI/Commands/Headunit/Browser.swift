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
//  Browser.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 13/12/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import Foundation



public struct Browser: OutboundCommand {

}

extension Browser: Identifiable {

    public static var identifier: Identifier = Identifier(0x0049)
}

extension Browser: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesType {

        case loadURL    = 0x00


        public static var all: [UInt8] {
            return [self.loadURL.rawValue]
        }
    }
}

public extension Browser {

    static var loadURL: (URL) -> [UInt8] {
        return {
            return identifier.bytes + [MessageTypes.loadURL.rawValue] + $0.propertyBytes(0x01)
        }
    }
}
