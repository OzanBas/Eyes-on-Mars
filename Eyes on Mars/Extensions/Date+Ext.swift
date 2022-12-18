//
//  Date+Ext.swift
//  Eyes on Mars
//
//  Created by Ozan Bas on 19.12.2022.
//

import Foundation

extension Date {
    
    func inNasaFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    
    }
}
