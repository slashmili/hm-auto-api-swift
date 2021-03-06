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
//  Coordinates.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 20/12/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import Foundation


#if os(macOS) || os(iOS) || os(tvOS) || os(watchOS)
    import CoreLocation
    public typealias Coordinates = CLLocationCoordinate2D
#else
    public struct Coordinates {

        public var latitude: Double
        public var longitude: Double


        public init(latitude: Double, longitude: Double) {
            self.latitude = latitude
            self.longitude = longitude
        }
    }

    extension Coordinates: Equatable {

        public static func ==(lhs: Coordinates, rhs: Coordinates) -> Bool {
            return (lhs.latitude == rhs.latitude) && (lhs.longitude == rhs.longitude)
        }
    }
#endif


extension Coordinates {

    var bytes: [UInt8] {
        return Float(latitude).bytes + Float(longitude).bytes
    }
}

extension Coordinates: BinaryInitable {

    init?<C>(_ binary: C) where C : Collection, C.Element == UInt8 {
        guard binary.count >= 8 else {
            return nil
        }

        let latitudeBytes = Float(binary.bytesArray.prefix(upTo: 4))
        let longitudeBytes = Float(binary.dropFirstBytes(4))

        self.init(latitude: Double(latitudeBytes), longitude: Double(longitudeBytes))
    }
}

extension Coordinates: PropertyConvertable {

    var propertyValue: [UInt8] {
        return bytes
    }
}
