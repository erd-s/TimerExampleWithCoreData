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
	var timer: Timer!
	var loggingRequested = false
	var cdh: CoreDataHelper!
	
	
	init(shouldLog: Bool) {
		loggingRequested = shouldLog
		cdh = CoreDataHelper(shouldLog: false)
	}
	
	/**
	Reinitializes the timer and fires, if this method is being called, the timer would have been nil or invalidated.
	*/
	func startTime() {
		if !timerGoing {
			timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in self.addSeconds() })
			timer.fire()
			timerGoing = true
			if loggingRequested { print("timer starting") }
		}
	}
	
	/**
	Stops the timer and invalidates it.
	*/
	func stopTime() {
		if timerGoing {
		timer.invalidate()
		timerGoing = false
			
		if loggingRequested { print("timer stopping") }
		}
	}
	
	/**
	This is what keeps time while the app is not running. It adds time elapsed while
	away to the core data entity and to this class's `totalSeconds` then fires the timer.
	*/
	func bankSecondsFrom(refDate: Date) {
		let timeElapsed = Date().timeIntervalSince(refDate)
		
		totalSeconds += Int(timeElapsed)
		cdh.getEntity()?.timeElapsed += Int64(timeElapsed)
		cdh.save()
		if loggingRequested { print("banking seconds: ", Int64(timeElapsed)) }

		startTime()
	}
	
	/**
	adds a second to `totalSeconds` and calls `delegate.timeUpdated` func.
	*/
	func addSeconds() {
		totalSeconds += 1
		if loggingRequested { print("adding seconds, total:", totalSeconds) }
		if (delegate != nil) { delegate.timeUpdated(totalSeconds: totalSeconds) }
	}
	
	/**
	Sets the reference date when the app disappears and invalidates the timer.
	*/
	func updateTimerForAppDisappear() {
		if loggingRequested { print("app disappearing") }
		if timerGoing {
			if let entity = cdh.getEntity() {
				entity.ref_date = NSDate()
				cdh.save()
			}
			stopTime()
		}
	}
	
	/**
	When the app becomes active again call this function. It banks the time elapsed
	and fires the timer.
	*/
	func updateTimerForAppReappear(force: Bool) {
		if loggingRequested { print("app reappearing. timer going = ", timerGoing) }
		
		if timerGoing || force {
			if let entity = cdh.getEntity() {
				if let refDate = entity.ref_date as? Date {
					bankSecondsFrom(refDate: refDate)
				} else {
					startTime()
				}
			} else {
				startTime()
			}
		}
	}
}
