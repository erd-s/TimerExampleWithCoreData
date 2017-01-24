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
	var vcDelegate: TimerControllerDelegate!
	var timer: Timer!
	
	init() {
		timer = Timer(timeInterval: 1, repeats: true, block: { _ in self.addSeconds() })
	}
	
	
	func startTime() {
		timer.fire()
	}
	
	func stopTime() {
		timer.invalidate()
	}
	
	func bankSecondsFrom(refDate: Date) {
		let timeElapsed = refDate.timeIntervalSince(Date())
		
		totalSeconds += Int(timeElapsed)
		if (vcDelegate != nil) { vcDelegate.timeUpdated(totalSeconds: totalSeconds) }
	}
	
	func addSeconds() {
		totalSeconds += 1
		
		if (vcDelegate != nil) { vcDelegate.timeUpdated(totalSeconds: totalSeconds) }
	}
}
