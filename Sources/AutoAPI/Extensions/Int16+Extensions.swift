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
//  Int16+Extensions.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 12/12/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import Foundation


extension Int16 {

    var bytes: [UInt8] {
        return UInt16(bitPattern: self).bytes
    }
}

extension Int16: BinaryInitable {

    init<C: Collection>(_ binary: C) where C.Element == UInt8 {
        self = binary.bytesArray.prefix(2).reduce(Int16(0)) { ($0 << 8) + $1.int16 }
    }
}

extension Int16: PropertyConvertable {

    var propertyValue: [UInt8] {
        return bytes
    }
}
