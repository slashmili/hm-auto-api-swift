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
//  Float+Extensions.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 30/11/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import Foundation


extension Float {

    var bytes: [UInt8] {
        return bitPattern.bytes
    }
}

extension Float: BinaryInitable {

    init<C>(_ binary: C) where C : Collection, C.Element == UInt8 {
        self = Float(bitPattern: UInt32(binary))
    }
}

extension Float: PropertyConvertable {

    var propertyValue: [UInt8] {
        return bytes
    }
}
