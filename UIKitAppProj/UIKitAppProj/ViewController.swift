//
//  ViewController.swift
//  UIKitAppProj
//
//  Created by Rajat Lakhina on 12/02/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tapAction(_ sender: Any) {
        
        let townHallVC = TownhallHostingViewController {
            TownhallHome()
        }
        self.navigationController?.pushViewController(townHallVC, animated: true)
    }
    
}
extension String {
    func strippingHTML() throws -> String?  {
        if isEmpty {
            return nil
        }
        
        if let data = data(using: .utf8) {
            let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ]
            
            let attributedString = try NSAttributedString(data: data, options: options, documentAttributes: nil)
            var string = attributedString.string
            
            // Replace object replacement characters
            string = string.replacingOccurrences(of: "\u{FFFC}", with: "")
            
            // Normalize multiple whitespaces and newlines to a single space or newline
            let whitespacePattern = "[ \\t\\r\\n]+"
            let whitespaceRegex = try NSRegularExpression(pattern: whitespacePattern, options: [])
            string = whitespaceRegex.stringByReplacingMatches(in: string, options: [], range: NSRange(location: 0, length: string.utf16.count), withTemplate: " ")
            
            return string.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        return nil
    }
    
    func getDateFormatServer(from format: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        var date = dateFormatter.date(from: self)
        if date == nil{
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            date = dateFormatter.date(from: self)
        }
        return date ?? Date()
    }
}
extension Date {
    func dateDifferenceFromSortAbrivation(date: Date) -> String {
        
        let dayHourMinuteSecond: Set<Calendar.Component> = [.year,.day,.month, .hour, .minute, .second]
        let difference = NSCalendar.current.dateComponents(dayHourMinuteSecond, from: date, to: self)
        let minutes = "\(difference.minute ?? 0)"
        let hours = "\(difference.hour ?? 0)"
        let days = "\(difference.day ?? 0)"
        let months = "\(difference.month ?? 0)"
        let years = "\(difference.year ?? 0)"
        if let year = difference.year, year > 0 {
            return "\(years) yr"
        }
        if let month = difference.month, month > 0 {
            return "\(months) mo"
        }
        if let day = difference.day, day > 0 {
            if day == 1 {
                return "\(days) d"
            }else{
                if day > 7 {
                    let week = day / 7
                    return "\(week) wk"
                    
                }else{
                    return "\(days) d"
                }
            }
        }
        if let hour = difference.hour, hour > 0 {
            return "\(hours) hr"
        }
        if let minute = difference.minute, minute > 0 {
            return "\(minutes) min"
        }
        return "afew moment ago"
    }
}
