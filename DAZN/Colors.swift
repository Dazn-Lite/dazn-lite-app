//
//  Colors.swift
//  DAZN
//
//  Created by Jakub Malczyk on 13/07/2022.
//

import Foundation
import UIKit


enum Color{
    
    case Asphalt
    case Chalk
    case Concrete
    case Ebony
    case GlovesDark
    case GlovesLight
    case Iron
    case Mako
    case Neon
    case Tarmac
    
    var getColor : UIColor {
        switch self {
        case .Asphalt: return UIColor(named: "Asphalt")!
        case .Chalk: return UIColor(named: "Chalk")!
        case .Concrete: return UIColor(named: "Concrete")!
        case .Ebony: return UIColor(named: "Ebony")!
        case .GlovesDark: return UIColor(named: "GlovesDark")!
        case .GlovesLight: return UIColor(named: "GlovesLight")!
        case .Iron: return UIColor(named: "Iron")!
        case .Mako: return UIColor(named: "Mako")!
        case .Neon: return UIColor(named: "Neon")!
        case .Tarmac: return UIColor(named: "Tarmac")!
            
            
        }
    }
    
}

