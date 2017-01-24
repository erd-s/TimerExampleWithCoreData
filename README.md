# TimerExampleWithCoreData

Instructions to use in your own AppDelegate and View Controllers.

### AppDelegate

1. Initialize TimerController and CoreDataHelper in didFinishLaunching.
2. Call `timerController.updateTimerForAppDisappear()` in the following:
  1. willResignActive
  2. didEnterBackground
  3. willTerminate
3. Call `timerController.updateTimerForAppReappear(force: false)` in willEnterForeground
4. Call `timerController.updateTimerForAppReappear(force: true)` in didBecomeActive. In didBecomeActive I'm using a `justLaunched` Bool to make sure this is not called when the app first launched.
  ex: 
   
    ```
    if !justLaunched { timerController.updateTimerForAppReappear(force: true) }
		justLaunched = false
    ```
    
### View Controller
1. In your View Controller make sure you are using AppDelegates instance of TimerController.

  ```
  timerController = (UIApplication.shared.delegate as! AppDelegate).timerController
  ```
2. Set the delegate.

  ```
  timerController.delegate = self
  ```
3. Implement delegate method

```
func timeUpdated(totalSeconds: Int) {
		exampleEntity.timeElapsed = Int64(totalSeconds)
		cdh.save()
		timeLabel.text = totalSeconds.timeDisplay()
	}
```
4. Connect Action

```
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
  ```
  
### Notes
##### Core Data
  1. Make sure your core data objects have these three variables:
    1. ref_date w/ type NSDate
    2. timeElapsed w/ type Int64
    3. timerGoing w/ type Boolean
    
##### Core Data Helper
  1. You'll want to implement your own fetching according to your own queries. For the sake of this proof-of-concept, I'm just retrieving the first entity found and writing to it.
  2. You can turn off logging by changing shouldLog to false where CoreDataHelper is initialized.

#### Timer Controller
  1. Same thing, you can turn off logging by changing shouldLog to false where TimerController is initialized **(should be AppDelegate)**.
