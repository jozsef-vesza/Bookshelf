//
//  RequestType.swift
//  
//
//  Created by József Vesza on 2023. 05. 10..
//

import Foundation

public enum RequestType {
    case plain
    case withParameters(parameters: [String: Any])
}
