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
//  DriverFatigue.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 12/12/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import Foundation


public struct DriverFatigue: InboundCommand {

    public let fatigueLevel: FatigueLevel?


    // MARK: InboundCommand

    public let properties: Properties


    init?(_ messageType: UInt8, properties: Properties) {
        guard messageType == 0x01 else {
            return nil
        }

        // Ordered by the ID
        fatigueLevel = FatigueLevel(rawValue: properties.first(for: 0x01)?.monoValue)

        // Properties
        self.properties = properties
    }
}

extension DriverFatigue: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesType {

        case driverFatigueDetected  = 0x01


        public static var all: [UInt8] {
            return [self.driverFatigueDetected.rawValue]
        }
    }
}

extension DriverFatigue: Identifiable {

    public static var identifier: Identifier = Identifier(0x0041)
}
