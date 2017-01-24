//
//  Int + Extension.swift
//  TimerExampleWithCoreData
//
//  Created by Christopher Erdos on 1/24/17.
//  Copyright © 2017 Erdos. All rights reserved.
//

import Foundation



extension Int {
	/**
	- returns: A string formatted 0d : 0h : 0m : 0s.
	*/
	func timeDisplay() -> String {
		var days = 0
		var hours = 0
		var mins = 0
		var secs = 0
		
		days = self / 86400
		hours = self % 86400 / 3600
		mins = self % 86400 % 3600 / 60
		secs = self % 86400 % 3600 % 60
		
		if (days == 0) && (hours == 0) && (mins == 0) {
			return ("\(secs)s")
		} else if (days == 0) && (hours == 0) {
			return ("\(mins)m : \(secs)s")
		} else if days == 0 {
			return ("\(hours)h : \(mins)m : \(secs)s")
		} else {
			return ("\(days)d : \(hours)h : \(mins)m : \(secs)s")
		}
	}
}
