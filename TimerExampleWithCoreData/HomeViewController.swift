//
//  HomeViewController.swift
//  TimerExampleWithCoreData
//
//  Created by Christopher Erdos on 1/24/17.
//  Copyright © 2017 Erdos. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {
	//--------------------------------------
	// MARK: - Properties
	//--------------------------------------
	let cdh = CoreDataHelper(shouldLog: true)
	var exampleEntity: ExampleEntity!
	var timerController = TimerController()
	
	
	//--------------------------------------
	// MARK: - Outlets
	//--------------------------------------
	@IBOutlet weak var timeLabel: UILabel!
	
	
	
	//--------------------------------------
	// MARK: - View Load
	//--------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
		timerController.vcDelegate = self
    }
	
	//--------------------------------------
	// MARK: - Create/Load CoreDataObject
	//--------------------------------------
	func createOrLoadEntity() {
		if let entity = cdh.getEntity() {
			exampleEntity = entity
		} else {
			exampleEntity = cdh.createEntity()
		}
	}
	
	
	//--------------------------------------
	// MARK: - Timer Start/Stop
	//--------------------------------------
	@IBAction func startStopButtonTapped(_ sender: Any) {
		timerController.timerGoing ? timerController.stopTime() : timerController.startTime()
	}
}



extension HomeViewController: TimerControllerDelegate {
	func timeUpdated(totalSeconds: Int) {
		exampleEntity.timeElapsed = Int64(totalSeconds)
		cdh.save()
		timeLabel.text = totalSeconds.timeDisplay()
	}
}






