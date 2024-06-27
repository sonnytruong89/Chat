//
//  Roshambo.swift
//  
//
//  Created by Vito Royeca on 6/26/24.
//

import Foundation

public class Roshambo {
    public static let shared = Roshambo()
    
    public let unicodeRock     = "\u{270A}"
    public let unicodePaper    = "\u{270B}"
    public let unicodeScissors = "\u{270C}"
    public let prefix = "/roshambo "
    
    private init() {
        
    }
    
    public func generate() -> String {
        switch arc4random_uniform(3) {
        case 0:
            return unicodeRock
        case 1:
            return unicodePaper
        case 2:
            return unicodeScissors
        default:
            return unicodeRock
        }
    }
    
    public func isRoshambo(_ string: String) -> Bool {
        string.starts(with: prefix)
    }
    
    public func values() -> [String] {
        [unicodeRock,
         unicodePaper,
         unicodeScissors]
    }
}
