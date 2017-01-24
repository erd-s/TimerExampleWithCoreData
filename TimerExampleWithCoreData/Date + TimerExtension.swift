//
//  Date + TimerExtension.swift
//  TimerExampleWithCoreData
//
//  Created by Christopher Erdos on 1/24/17.
//  Copyright © 2017 Erdos. All rights reserved.
//

import Foundation
import UIKit

let timestampFormat = "yyyy-MM-dd_HH:mm:ss"

extension Date {
	/**
	- returns: A string with the date formatted as `yyyy-MM-dd_HH:mm:ss`.
	*/
	func timestamp() -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = timestampFormat
		
		return dateFormatter.string(from: self)
	}
}
