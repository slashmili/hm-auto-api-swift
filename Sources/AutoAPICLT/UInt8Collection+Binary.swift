//
// AutoAPI CLT
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
//  UInt8Collection+Binary.swift
//  AutoAPI
//
//  Created by Mikk Rätsep on 23/11/2017.
//  Copyright © 2017 High Mobility. All rights reserved.
//

import Foundation


extension Collection where Element == UInt8 {

    var bytesArray: [UInt8] {
        return Array(self)
    }

    var data: Data {
        return Data(bytes: bytesArray)
    }

    var hex: String {
        return map { String(format: "%02X", $0) }.joined()
    }


    func dropFirstBytes(_ n: Int) -> [UInt8] {
        return bytesArray.dropFirst(n).bytesArray
    }
}
