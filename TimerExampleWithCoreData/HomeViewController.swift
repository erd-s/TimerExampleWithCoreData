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
	var timerController: TimerController!
	
	
	//--------------------------------------
	// MARK: - Outlets
	//--------------------------------------
	@IBOutlet weak var timeLabel: UILabel!
	@IBOutlet weak var startStopButton: UIButton!
	
	
	//--------------------------------------
	// MARK: - View Load
	//--------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
		
		timerController = (UIApplication.shared.delegate as! AppDelegate).timerController
		timerController.delegate = self
		createOrLoadEntity()
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
		timeLabel.text = Int(exampleEntity.timeElapsed).timeDisplay()
		timerController.totalSeconds += Int(exampleEntity.timeElapsed)
		
		if exampleEntity.timerGoing {
			if let refDate = exampleEntity.ref_date as? Date {
				print("got ref date:", refDate)
				timerController.bankSecondsFrom(refDate: refDate)
			} else {
				print("no ref date")
				timerController.startTime()
			}
			
			startStopButton.setTitle("S T O P", for: .normal)
		}
	}
	
	
	//--------------------------------------
	// MARK: - Timer Start/Stop
	//--------------------------------------
	@IBAction func startStopButtonTapped(_ sender: Any) {
		if timerController.timerGoing {
			startStopButton.setTitle("S T A R T", for: .normal)
			timerController.stopTime()
			exampleEntity.timerGoing = false
		} else {
			startStopButton.setTitle("S T O P", for: .normal)
			timerController.startTime()
			exampleEntity.timerGoing = true
		}
		cdh.save()
	}
}

extension HomeViewController: TimerControllerDelegate {
	func timeUpdated(totalSeconds: Int) {
		exampleEntity.timeElapsed = Int64(totalSeconds)
		cdh.save()
		timeLabel.text = totalSeconds.timeDisplay()
	}
}






