//
//  ErrorConstants.swift
//  USA_Geo
//
//  Created by MANISH on 12/07/17.
//  Copyright © 2017 Manish. All rights reserved.
//

import Foundation

enum JsonError:Error {
    case ObjectNotArray
    case ObjectNotDictionary
    case FilePathNotFound
    case DataNotFound
    case ParsingFailed
}
