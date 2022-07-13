//
//  VCExtensions.swift
//  DAZN
//
//  Created by Jakub Malczyk on 13/07/2022.
//

import Foundation
import UIKit

extension ViewController{
    func getHeight() -> CGFloat{
        let guide = self.view.safeAreaLayoutGuide
        let height = guide.layoutFrame.size.height
        
        return height

    }
    
    func getWidth() -> CGFloat{
        let guide = self.view.safeAreaLayoutGuide
        let width = guide.layoutFrame.size.width
        
        return width
    }
    
}
