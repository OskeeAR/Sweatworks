# SweatWorks test

## Introduction

Being that iOS 11 is installed in around %59 of iOS Devices and iOS 11 on around %33 (http://appleinsider.com/articles/17/12/05/apples-ios-11-installed-on-59-of-compatible-devices-up-7-from-november) I chose the latter to be the application minimum required version for the app to be installed, reaching a very high user percentage rate. The code has been written sticking to the best practices proposed throughout the Ray Wanderlich style guide (https://github.com/raywenderlich/swift-style-guide). The strings are all gathered in the ‘Definitions’ class and defined using NSLocalizedString, this would be an advantage if the application is intended to support multiple languages in the future.
	
	

## Design of the app

This application was built using a MVP pattern. This pattern helps structure the code more efficiently than in a traditional MVC pattern. It also adds a layer between the ViewControllers and the DB service, so in case a new technology emerges and we don’t want to use CoreData anymore, we should only replace the MasterService and DetailServices classes, honoring their APIs so the other components of the MVP can request the information this class provides. Another advantage of using MVP is that this code is  simpler to test using this design.

## Platform support

The platforms required in the specification were implemented. The iPhone 5S, iPhone 8 and 8Plus as well as the iPad 2 (Actually with Xcode 9.2 it’s iPad Air 2). The same app/binary works for both platforms (iPhone/iPad), making the interface adapt itself using a SplitViewController in the case of the iPad and a NavigationController in the case of the iPhones.

## Code cleaness

- The Xcode project is configured to treat Warnings as Errors, so if their is any Warning the app won’t even compile. This guarantees that the warnings are fixed immediately, resulting in better and safer code.
- All the functions that might fail (in the case of the current project everything that has to do with writing or reading in the Database, hence accessing the disk) are implemented using try-catch so if an error raises (disk is full, DB record is not available anymore, etc) the user is presented with a proper error message with if available suggestion to fix the error.
- For making sure the memory is handled correctly throughout the program I used a couple of techniques. I add a print in the objects that I expect to be released, this is a first way to make sure that the objects you no longer want in the heap get released as expected. Through the Xcode run time built-in memory inspector, plus the Instruments app I run performance test throughout the application, and make sure memory gets allocated and later deallocated as expected.
