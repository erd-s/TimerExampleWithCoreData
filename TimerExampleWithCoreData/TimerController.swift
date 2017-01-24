//
//  TimerController.swift
//  TimerExampleWithCoreData
//
//  Created by Christopher Erdos on 1/24/17.
//  Copyright © 2017 Erdos. All rights reserved.
//

import Foundation
import UIKit

protocol TimerControllerDelegate {
	func timeUpdated(totalSeconds: Int)
}

class TimerController {
	var totalSeconds = 0
	var timerGoing = false
	var delegate: TimerControllerDelegate!
	
	
	
	
	
	func bankSecondsFrom(refDate: Date) {
		
	}
	
	func addSeconds() {
		totalSeconds += 1
		
		if (delegate != nil) { delegate.timeUpdated(totalSeconds: totalSeconds) }
	}
}
