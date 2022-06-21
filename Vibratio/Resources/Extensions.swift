//
//  Extensions.swift
//  SpotifyUIKit
//
//  Created by hunter downey on 4/27/22.
//

import Foundation
import UIKit

extension UIView {
    var width: CGFloat {
        return frame.size.width
    }
    
    var height: CGFloat {
        return frame.size.height
    }
    
    var left: CGFloat {
        return frame.origin.x
    }
    
    var right: CGFloat {
        return left + width
    }
    
    var top: CGFloat {
        return frame.origin.y
    }
    
    var bottom: CGFloat {
        return top + height
    }
}

extension DateFormatter {
    static let dateFormatter: DateFormatter = {
        let dateFortmatter = DateFormatter()
        dateFortmatter.dateFormat = "YYYY-MM-dd"
        return dateFortmatter
    }()
    
    static let displayDateFormatter: DateFormatter = {
        let dateFortmatter = DateFormatter()
        dateFortmatter.dateStyle = .medium
        return dateFortmatter
    }()
}

extension String {
    static func formattedDate(string: String) -> String {
        guard let date = DateFormatter.dateFormatter.date(from: string) else {
            return string
        }
        return DateFormatter.displayDateFormatter.string(from: date)
    }
}
