//
//  AlertControllerStyle.swift
//  AlertController
//
//  Created by phimage on 28/10/16.
//  Copyright © 2016 phimage. All rights reserved.
//

import Foundation
import AppKit

extension AlertController {
    public enum Style  {
        
        case warning
        
        case informational
        
        case critical
        
        case custom(NSImage)

        fileprivate var icon: String {
            switch self {
            case .informational:
                return "AlertNoteIcon"
            case .critical:
                return "AlertStopIcon"
            case .warning:
                return "AlertCautionIcon"
            case .custom:
                return ""
            }
        }
        
        public var image: NSImage? {
            if case .custom(let im) = self {
                return im
            }
            let bundle = Bundle(for: AlertController.self)
            guard let path = bundle.path(forResource: icon, ofType: "icns") else {
                return nil
            }
            return NSImage(contentsOfFile: path)
        }
        
    }
}

extension AlertController.Style: Equatable {
    
    public static func == (lhs: AlertController.Style, rhs: AlertController.Style) -> Bool {
        switch (lhs, rhs) {
        case (.warning, .warning): return true
        case (.critical, .critical): return true
        case (.informational, .informational): return true
        case (.custom(let lim), .custom(let rim)): return lim == rim
        default: return false
        }
    }

}
