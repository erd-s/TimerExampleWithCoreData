//
//  String + TimerExtension.swift
//  TimerExampleWithCoreData
//
//  Created by Christopher Erdos on 1/24/17.
//  Copyright © 2017 Erdos. All rights reserved.
//

import Foundation

extension String {
	
	
	
	
	/**
	Returns a date given the timestamp format globally declared in Date + TimerExtension
	*/
	func date() -> Date? {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = timestampFormat
		
		return dateFormatter.date(from: self)
	}
}
