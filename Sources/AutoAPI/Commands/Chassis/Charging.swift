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
//  Charging.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/11/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import Foundation


public struct Charging: FullStandardCommand {

    public let batteryCurrentAC: Float?
    public let batteryCurrentDC: Float?
    public let batteryLevel: UInt8?
    public let chargeLimit: UInt8?
    public let chargePortState: ChargePortState?
    public let chargerVoltageAC: Float?
    public let chargerVoltageDC: Float?
    public let chargingRate: Float?
    public let chargingState: ChargingState?
    public let estimatedRange: UInt16?
    public let timeToCompleteCharge: UInt16?


    // MARK: FullStandardCommand

    public let properties: Properties


    init?(properties: Properties) {
        // Ordered by the ID
        chargingState = ChargingState(rawValue: properties.first(for: 0x01)?.monoValue)
        estimatedRange = properties.value(for: 0x02)
        batteryLevel = properties.value(for: 0x03)
        batteryCurrentAC = properties.value(for: 0x04)
        batteryCurrentDC = properties.value(for: 0x05)
        chargerVoltageAC = properties.value(for: 0x06)
        chargerVoltageDC = properties.value(for: 0x07)
        chargeLimit = properties.value(for: 0x08)
        timeToCompleteCharge = properties.value(for: 0x09)
        chargingRate = properties.value(for: 0x0A)
        chargePortState = ChargePortState(rawValue: properties.first(for: 0x0B)?.monoValue)

        self.properties = properties
    }
}

extension Charging: Identifiable {

    public static var identifier: Identifier = Identifier(0x0023)
}

extension Charging: MessageTypesGettable {

    public enum MessageTypes: UInt8, MessageTypesType {

        case getChargeState         = 0x00
        case chargeState            = 0x01
        case startStopCharging      = 0x02
        case setChargeLimit         = 0x03
        case openCloseChargePort    = 0x04


        public static let getState = MessageTypes.getChargeState
        public static let state = MessageTypes.chargeState

        public static var all: [UInt8] {
            return [self.getChargeState.rawValue,
                    self.chargeState.rawValue,
                    self.startStopCharging.rawValue,
                    self.setChargeLimit.rawValue,
                    self.openCloseChargePort.rawValue]
        }
    }
}

public extension Charging {

    static var getChargeState: [UInt8] {
        return getState
    }

    static var openCloseChargePort: (ChargePortState) -> [UInt8] {
        return {
            return identifier.bytes + [MessageTypes.openCloseChargePort.rawValue, $0.rawValue]
        }
    }

    static var setChargeLimit: (UInt8) -> [UInt8] {
        return {
            return identifier.bytes + [MessageTypes.setChargeLimit.rawValue, $0]
        }
    }

    static var startStopCharging: (StartStopCharging) -> [UInt8] {
        return {
            return identifier.bytes + [MessageTypes.startStopCharging.rawValue, $0.rawValue]
        }
    }
}
