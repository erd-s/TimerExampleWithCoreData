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
	var loggingRequested = false
	var cdh: CoreDataHelper!
	
	init(shouldLog: Bool) {
		loggingRequested = shouldLog
		cdh = CoreDataHelper(shouldLog: false)
	}
	
	
	func startTime() {
		if !timerGoing {
			timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in self.addSeconds() })
			timer.fire()
			timerGoing = true
			if loggingRequested { print("timer starting") }
		}
		
	}
	
	func stopTime() {
		if timerGoing {
		timer.invalidate()
		timerGoing = false
			
		if loggingRequested { print("timer stopping") }
		}
	}
	
	func bankSecondsFrom(refDate: Date) {
		let timeElapsed = Date().timeIntervalSince(refDate)
		
		totalSeconds += Int(timeElapsed)
		cdh.getEntity()?.timeElapsed += Int64(timeElapsed)
		cdh.save()
		if loggingRequested { print("banking seconds: ", Int64(timeElapsed)) }

		startTime()
	}
	
	func addSeconds() {
		totalSeconds += 1
		if loggingRequested { print("adding seconds, total:", totalSeconds) }
		if (vcDelegate != nil) { vcDelegate.timeUpdated(totalSeconds: totalSeconds) }
	}
	
	func updateTimerForAppDisappear() {
		if loggingRequested { print("app disappearing") }
		if timerGoing {
			if let entity = cdh.getEntity() {
				entity.ref_date = NSDate()
				cdh.save()
			}
			stopTime()
			timer.invalidate()
		}
	}
	
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
