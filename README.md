# Pre-work - TipCalculator

TipCalculator is a tip calculator application for iOS.

Submitted by: Shai Zarif

Time spent: 5 hours spent in total

## User Stories

The following **required** functionality is complete:

* [X] User can enter a bill amount, choose a tip percentage, and see the tip and total values.
* [X] Settings page to change the default tip percentage.

The following **optional** features are implemented:
* [X] UI animations
* [ ] Remembering the bill amount across app restarts (if <10mins)
* [ ] Using locale-specific currency and currency thousands separators.
* [X] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:

- [ ] Allow to split the amount and make a payment request on Venmo
    - Started working it but found out Venmo does not have an API available for new users. I will continue to update the repo to find a way around it.

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/link/to/your/gif/file.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Project Analysis

As part of your pre-work submission, please reflect on the app and answer the following questions below:

**Question 1**: "What are your reactions to the iOS app development platform so far? How would you describe outlets and actions to another developer? Bonus: any idea how they are being implemented under the hood? (It might give you some ideas if you right-click on the Storyboard and click Open As->Source Code")

**Answer:** 
So Far I enjoyed iOS app development on xcode. The program works well, Apple really made sure that it is user friendly and they were able to simplify complicated problems in to a simple interface. Outlets allow for communication between an elements on the screen and the source code. Specifically, outlets provide a way to reference screen elements from the source code. Actions, allows the developer to do something when an element triggered an event.  

Looking at the XML that drives the story board,  I notice the hierarchy that is created in the source code as expected.  Each element has an ID that I am assuming is used in the code to reference that element. The action is nested in the element’s hierarchy under connections and it seems like the selector triggers the proper function.



Question 2: "Swift uses [Automatic Reference Counting](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/AutomaticReferenceCounting.html#//apple_ref/doc/uid/TP40014097-CH20-ID49) (ARC), which is not a garbage collector, to manage memory. Can you explain how you can get a strong reference cycle for closures? (There's a section explaining this concept in the link, how would you summarize as simply as possible?)"

**Answer:**
A strong reference cycle occurs when reference types (Classes and closures are reference types in Swift) hold strong reference to each other. This causes them to stay in the heap and keep each other alive, thus creating a memory leak. A closure is a self-contained block of code and can be passed around by reference. A strong reference cycle with a closure occurs when a closure is assigned to a property of a class instance and the body of the closure references that instance as well.  This essentially causes two by reference types to call each other. Now when we try to destroy the object that contains the closure,  it will not be deallocated because it will still be referenced by the closure inside it, and the closure inside it will still be referenced by the parent object. 


## License

    Copyright 2017 Shai Zarif

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.