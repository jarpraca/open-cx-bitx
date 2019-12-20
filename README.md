# openCX-*BitX* Development Report

Welcome to the documentation pages of the **BitX** of **openCX**!

You can find here detailed information about the (sub)product, hereby mentioned as module, from a high-level vision to low-level implementation decisions, a kind of Software Development Report (see [template](https://github.com/softeng-feup/open-cx/blob/master/docs/templates/Development-Report.md)), organized by discipline (as of RUP): 

* Business modeling 
  * [Product Vision](#Product-Vision)
  * [Elevator Pitch](#Elevator-Pitch)
* Requirements
  * [Use Case Diagram](#Use-case-diagram)
  * [User stories](#User-stories)
  * [Domain model](#Domain-model)
* Architecture and Design
  * [Logical architecture](#Logical-architecture)
  * [Physical architecture](#Physical-architecture)
  * [Prototype](#Prototype)
* [Implementation](#Implementation)
* [Test](#Test)
* [Configuration and change management](#Configuration-and-change-management)
* [Project management](#Project-management)

So far, contributions are exclusively made by the initial team, but we hope to open them to the community, in all areas and topics: requirements, technologies, development, experimentation, testing, etc.

Please contact us! 

Thank you!

João Praça<br />
Leonor Sousa<br />
Lucas Ribeiro<br />
Sílvia Rocha<br />

## Product Vision
Creating a product that improves the user experience in the check-in process.

## Elevator Pitch
Tired of waiting in infinite lines just to make a simple check-in?<br />
Tired of having that check-in made by ordinary people?<br />
Here in Bitx, We have the perfect solution for you: BotX! All you have to do is have your bluetooth on and as soon as you reach the place of the event, the check-in will be made automatically for you. You will then receive a QR-code with which you can collect your welcome kit. <br />
But that isn't enough, is it? <br />
Well, if you are one of the lucky ones, you will be rewarded with a special surprise: BotX, our genial robot will be the one delivering the welcome kit to you.<br />
Are you ready for the best check-in of your life?!<br />

## Requirements

Our product will result in two subproducts that interact with each other: the automatic check-in (provided by the app and beacon working together) and, for some of the users, a robot that will deliver the welcome kit.

For this, we need to build an app that fulfills some requirements
* Has the login and the logout functionalitys
* Informs the user to turn on the bluetooth
* Has an help page to inform the user on how the product works
* Informs the user when the check-in was completed
* Gives the user a QR-code so he can collect the welcome kit, if he was not selected
* Gives the user the information that he was selected to receive the kit by the robot

The server must be able to fulfill some other requirements:
* Comunicate with the robot, in order to send it to the selected user
* Generate and save the QR-codes generated
* Save information on which QR-codes have already been read (so the same user isn't able to collect more than one welcome kit)

The robot must fulfill the following requirements:
* Meet the user (using the beacon to find out its location)
* Able to read the QR-code of the user
* Only give the kit to the user if the QR-code is valid


## Use case diagram 

<img alt="Use Case Diagram" src="./images/Use_Case_Diagram.png" width="600">

### Login

**Actor:** Atendee and conference participant

**Description:** To do the login, the user only needs to insert the code he received when he bought the ticket. 

**Preconditions and Postconditions:** The user must be logged out, own a ticket and have his code ready to be inserted. After logging in, the app will start searching for the entrance's beacon.

**Normal Flow:**
* User selects the login option in the main screen
* User inputs the ticket code in the respective field
* User is logged in

**Alternative Flows and Exceptions:** 
* If the user enters any invalid input he will not be logged in and will be asked to fill in the code correctly.
*If the user does not remember his code, he will access the recover code screen</br>

</br>

### Check-in

**Actor:** Atendee and conference participant

**Description:** The user is automatically checked in by arriving at FEUP 

**Preconditions and Postconditions:** A beacon must be instaled in FEUP's entrance. The user must be logged in and have his bluetooth turned on so the beacon can be detected. After being checked in, the user will receive a notification and the app will display if the user will be given a welcome kit by the robot or by a staff member.

**Normal Flow:**
* User is logged in
* User turns on bluetooth
* User arrives at FEUP
* User is checked in
* User is notified

**Alternative Flows and Exceptions:** 
* If the user isn't logged in, than he will be in the page for the login. 
* If the user's bluetooth is off, he will not be checked in and will be asked to turn on the bluetooth. 
* If the user isn't in the perimeter of the beacon, he will be in a page telling him the check-in still hasn't been completed. 

</br>

### Show QR Code

**Actor:** Atendee and conference participant

**Description:** The user shows his QR Code to the robot or at the welcome desk and receives his goodies bag

**Preconditions and Postconditions:** Being checked in and having the QR Code. After showing the QR Code to the robot, it will release a gift bag.

**Normal Flow:**
* User is checked in
* User has the QR Code
* User shows the QR Code
* User receives a gift bag

**Alternative Flows and Exceptions:** 
* If the check-in isn't completed, another page will be shown 

</br>

### Logout

**Actor:** Atendee and conference participant

**Description:** To log out, the user needs to press the logout button.

**Preconditions and Postconditions:** The user must have a ticket and be logged in. After logging out, the user won't have access to the check-in page until he logs in again.

**Normal Flow:**
* User is logged in
* User presses logout button
* User is logged out

**Alternative Flows and Exceptions:** 
* If the user isn't logged in then we won't have a button to logout

</br>

### Recover Code

**Actor:** Atendee and conference participant

**Description:** When a user does not have his ticket code he can recover it by email

**Preconditions and Postconditions:** Having a ticket. After recovering the code, the user will have a new code will be able to login.

**Normal Flow:**
* User has a ticket
* User wants to login but doesn't remember code
* User opens recovery screen
* User gives his email
* User receives email with password recovery option

**Alternative Flows and Exceptions:** 
* If the user doesn't have a ticket or inputs a invalid email he will be told so and will have to input a valid email 

</br>

### Receive Kit

**Actor:** Atendee and conference participant

**Description:** If the user is one of the selected ones he will receive is gift bag by a robot

**Preconditions and Postconditions:** Being checked in, having the QR Code and showing it to the robot. After this, the robot releases a gift bag and the user will be able to take full advantage of it.

**Normal Flow:**
* User is checked in
* User is one of the selected ones
* User has the QR Code
* User shows the QR Code to the robot
* User receives gift bag

</br>

**Alternative Flows and Exceptions:** 
* If the check-in isn't completed, another page will be shown 
* If the user isn't one of the selected ones he should go to the welcome desk to receive his bag

In any of this use cases, if there is a problem communicating with the server (example: checking for the valid code in the login, generating the QR-code, registering the check-in, etc.), the user should be redirected to a page informing him there has been an error and asking him to go the help center.

</br>

## User stories

### User story #1
> As a user that has bought a ticket, I am required to insert my code to be able to use the app.

**Acceptance Test:** <br>
&nbsp;&nbsp;&nbsp;Given a user with a ticket<br>
&nbsp;&nbsp;&nbsp;When the user tries to access the check-in <br>
&nbsp;&nbsp;&nbsp;Then the user is required to insert the code <br>
&nbsp;&nbsp;&nbsp;And the user should be redirected to the beacon interaction screen <br>

**Value:** Must Have <br>
**Effort:** L <br>

### User story #2

> As a logged in user, I would like to receive some informations on how to do my check in.

**Acceptance Test:** <br>
&nbsp;&nbsp;&nbsp;Given a user that has the app<br>
&nbsp;&nbsp;&nbsp;When the user wants to know some information about the check-in process<br>
&nbsp;&nbsp;&nbsp;Then the user can see that information in the help section of the app <br>

**Value:** Could Have <br>
**Effort:** S <br>

### User story #3

> As a user who has lost his code, I would like to be able to recover it, inserting my email.

**Acceptance Test:** <br>
&nbsp;&nbsp;&nbsp;Given a user that has bought a ticket<br>
&nbsp;&nbsp;&nbsp;When the user forgets its code <br>
&nbsp;&nbsp;&nbsp;Then the user receives an email with its code <br>

**Value:** Should Have <br>
**Effort:** M <br>


### User story #4 
> As a checked-in user, I would like to receive a notification informing me the check-in is done.

**Acceptance Test:** <br>
&nbsp;&nbsp;&nbsp;Given a logged in user <br>
&nbsp;&nbsp;&nbsp;When the user gets automatically checked-in <br>
&nbsp;&nbsp;&nbsp;Then the user is notified <br>

**Value:** Could Have <br>
**Effort:** M <br>

### User story #5 

> As a selected user, I would like to be received by a robot.

**Acceptance Test:** <br>
&nbsp;&nbsp;&nbsp;Given a checked-in user<br>
&nbsp;&nbsp;&nbsp;When the user is selected to be received by BotX <br>
&nbsp;&nbsp;&nbsp;Then BotX goes to the user and delivers the welcome kit <br>

**Value:** Should Have <br>
**Effort:** L <br>

### User story #6

> As a non selected user, I would like to receive my welcome kit in the welcome desk.

**Acceptance Test:** <br>
&nbsp;&nbsp;&nbsp;Given a checked-in and non selected user<br>
&nbsp;&nbsp;&nbsp;When the user shows the QR Code <br>
&nbsp;&nbsp;&nbsp;Then the user receives the welcome kit at the welcome desk <br>

**Value:** Should Have <br>
**Effort:** M <br>

### User story #7

> As a user who still doesn't have a ticket, I would like to buy a ticket and register.

**Acceptance Test:** <br>
&nbsp;&nbsp;&nbsp;Given a user that does not have a ticket<br>
&nbsp;&nbsp;&nbsp;When the user opens the app <br>
&nbsp;&nbsp;&nbsp;Then the user can access the registration link through the app <br>

**Value:** Could Have <br>
**Effort:** M <br>

### User story #8 
> As a logged in user, I would like to be automatically checked in.

**Acceptance Test:** <br>
&nbsp;&nbsp;&nbsp;Given a logged in user<br>
&nbsp;&nbsp;&nbsp;When the user arrives at FEUP (the beacon is detected) <br>
&nbsp;&nbsp;&nbsp;Then the user is automatically checked-in <br>

**Value:** Must Have <br>
**Effort:** XL <br>


### User story #9

> As a user, when I log in, I would like to be asked to turn on my bluetooth.

**Acceptance Test:** <br>
&nbsp;&nbsp;&nbsp;Given a user that has a ticket<br>
&nbsp;&nbsp;&nbsp;When the user logs in <br>
&nbsp;&nbsp;&nbsp;Then the user is required to turn on the bluetooth <br>

**Value:** Must Have <br>
**Effort:** M <br>

### Domain model

<img alt="Domain Model" src="./images/DomainModel.png" width="800">

In a conference, an **atendee** is associated with its **ticket** and a **place** (that can be a room, a hallway, WC or any other zone of where the conference is taking place). However, in the specific case of our project, it is only of concern when an atendee is in the entrance of FEUP, where the check-in would be done automatically because the app would detect its unique beacon.

---

## Architecture and Design

While developing this project, we always aimed to create an organized, understandable, optimized and overall well built product. To help achieve that, we applied some architecture and design techniques described below.

### Logical architecture
<img alt="Logical Architecture" src="./images/LogicalArchitecture.png" width="800"> 

To organize our software and keep it clean and easily understandable to other developers, we decided to split our code into packages. The main three **packages** are:
* **Authentication**: responsible for logging in and recovering the ticket code.
* **Utilities**: contains the help and welcome pages.
* **Automatic Check-in**: in charge of automatically checking in the atendee; it is divided in two packages:
    * **Check-in States**: comprises all the states of an atendee in terms of check-in: not done, done and selected (to be greeted by the robot) and done but not selected.
    * **Beacon Interaction**: detects the FEUP entrance's beacon using a third-party package.

### Physical architecture
<img alt="Physical Architecture" src="./images/PhysicalArchitecture.png" width="800">

From a hardware point of view, our system consists in the **app** BotX, that detects **beacons** (specifically the entrance's beacon) and that connects to a **server**, which then requests a **robot** to come greet a selected antendee and offer him some goodies.

For the frontend development of this application we used **Flutter**. This choice was based on two considerations: the first one is that on an open source project having a standardized language is of great importance; the second one is that this is a frequently used framework in the community so we were able to find a lot of third-party packages and support. One of those packages was used to interact with the bluetooth and the beacon itself. The beacon interaction package simply looks for a specific beacon in the range area.

The robot related feature was not implemented inside this project because the two main components of its interaction (robot and backend) were already being developed by other groups. We intended to integrate both apps, but due to time restrictions and the lack of backend features needed to connect the projects.

### Prototype

At this initial point, our main focus was to **plan** the project, **prepare** the process and **structure** our app.

At first, we started by searching for the most suitable programming language for our project, and between our two final options, React Native or **Flutter**, the latter was the chosen one.

The next step was to find a way to detect if the user had arrived at the conference, so we investigated and found **beacons** to be the best choice.

As another group was also working with a **robot**, we decided from this point that we would join forces and aimed to connect both projects in the future to create a better experience for the atendees.

Finally, we started creating most of the **mockups** for the app's main screens (one screen per user story), which were then refined and finished in Iteration 1.

---

## Implementation

### Product Increment #1

In this increment the planning phase was concluded with the help of a project management tool (Trello).
* Categorization of each feature by effort and value for the project
* Research about Scrum Methods 
* Division of features into iterations, organizing them by value
* Creation of the backlog and to do lists
* Refinement of the user stories and use cases
* Choosing of the programming language best suited for the project
* Design of mockups of the app's screens.

<div style="display: flex; flex-wrap: wrap; justify-content: space-evenly">
    <img style="margin: 20px 0" src="images/mainScreen_mockup.png" alt="Mockup Main Screen"  width="189" />
    <img style="margin: 20px 0" src="images/help_mockup.png" alt="Mockup Help Screen"  width="189" /> 
    <img style="margin: 20px 0" src="images/login_mockup.png" alt="Mockup Login Screen"  width="189"/> 
    <img style="margin: 20px 0" src="images/recoverCode_mockup.png" alt="Mockup Recover Code Screen"  width="189" /> 
    <img style="margin: 20px 0" src="images/bluetooth_mockup.png" alt="Mockup Bluetooth Screen"  width="189" />
    <img style="margin: 20px 0" src="images/notCheckedIn_mockup.png" alt="Mockup Not Checked In Screen"  width="189" /> 
    <img style="margin: 20px 0" src="images/selected_mockup.png" alt="Mockup Selected User Screen"  width="189" />
    <img style="margin: 20px 0" src="images/notSelected_mockup.png" alt="Mockup Not Selected User Screen"  width="189" />
</div>

### Product Increment #2 

In this increment we started the execution and the monitoring and control phases of the project.

* Implemented a status report politic where all elements of the group had to report the evolution of their tasks every few days
* Started the mobile application structure
* Created most of the screens of our application (visual component)
* Research about how beacons work and what packages were available for their integration with flutter

<div style="display: flex; flex-wrap: wrap; justify-content: space-evenly">
    <img style="margin: 20px 0" src="images/mainScreen_iteration2.png" alt="Iteration 2 Main Screen"  width="189" />
    <img style="margin: 20px 0" src="images/help_iteration2.png" alt="Iteration 2 Help Screen"  width="189" /> 
    <img style="margin: 20px 0" src="images/login_iteration2.png" alt="Iteration 2 Login Screen"  width="189" /> 
    <img style="margin: 20px 0" src="images/recoverCode_iteration2.png" alt="Iteration 2 Recover Code Screen"  width="189" /> 
    <img style="margin: 20px 0" src="images/bluetooth_iteration2.png" alt="Iteration 2 Bluetooth Screen"  width="189" />
    <img style="margin: 20px 0" src="images/notCheckedIn_iteration2.png" alt="Iteration 2 Not Checked In Screen"  width="189"/> 
    <img style="margin: 20px 0" src="images/selected_iteration2.png" alt="Iteration 2 Selected User Screen"  width="189"/>
    <img style="margin: 20px 0" src="images/notSelected_iteration2.png" alt="Iteration 2 Not Selected User Screen"  width="189"/>
</div>

### Product Increment #3

In this increment we dedicated our efforts into the logic behind the screens.</br>
We decided not to implement the backend component for our application given that some of our features where common with a lot of other groups (login, password recovery, among others) so we thought it made sense to focus our efforts in the exclusive feature that our application presented: the automatic check-in through beacon detection.

* Implementation of the beacon detection 
* Implementation of a primitive version of the bluetooth detection
* Code cleanup inside each screen
* Improvement of the screens' layout
* Improvement of the application's navigation
* Added correct behavior after the beacon detection

<div style="display: flex; flex-wrap: wrap; justify-content: space-evenly">
    <img style="margin: 20px 0" src="images/mainScreen_iteration3.png" alt="Iteration 3 Main Screen"  width="189" />
    <img style="margin: 20px 0" src="images/help_iteration3.png" alt="Iteration 3 Help Screen"  width="189"/> 
    <img style="margin: 20px 0" src="images/login_iteration3.png" alt="Iteration 3 Login Screen"  width="189" /> 
    <img style="margin: 20px 0" src="images/recoverCode_iteration3.png" alt="Iteration 3 Recover Code Screen"  width="189"/> 
    <img style="margin: 20px 0" src="images/bluetooth_iteration3.png" alt="Iteration 3 Bluetooth Screen"  width="189" />
    <img style="margin: 20px 0" src="images/notCheckedIn_iteration3.png" alt="Iteration 3 Not Checked In Screen"  width="189" /> 
    <img style="margin: 20px 0" src="images/selected_iteration3.png" alt="Iteration 3 Selected User Screen"  width="189" />
    <img style="margin: 20px 0" src="images/notSelected_iteration3.png" alt="Iteration 3 Not Selected User Screen"  width="189" />
</div>

### Product Increment #4
At this point, our main focus was to organize the code and guarantee that all main features where correctly implemented.

* Implemented a better version of the bluetooth detection 
* Refined beacon detection and the behavior afterwards
* Implemented QR Code Generator
* Implemented local notifications to inform the user when the check in is completed
* Created functions to verify input in login and recover code screens. In the login screen the user only has to insert something for it to work (without a backend we did not have a way to verify if the code is valid). In the recover code input the user must insert teste@gmail.com for it to recognize it as a valid email (again with no backend there wasn't a way to know if there was actually an account with that email)
* Refactor of the code to divide it in the correct packages (done after the deadline for the increment #4 so it does not appear inside the iteration_4 release)
* Report Improvements

<div style="display: flex; flex-wrap: wrap; justify-content: space-evenly">
    <img style="margin: 20px 0" src="images/mainScreen_iteration4.png" alt="Iteration 4 Main Screen"  width="189"/>
    <img style="margin: 20px 0" src="images/help_iteration4.png" alt="Iteration 4 Help Screen"  width="189" /> 
    <img style="margin: 20px 0" src="images/login_iteration4.png" alt="Iteration 4 Login Screen"  width="189"/> 
    <img style="margin: 20px 0" src="images/login_badInput.png" alt="Iteration 4 Login Invalid Input"  width="189" /> 
    <img style="margin: 20px 0" src="images/recoverCode_iteration4.png" alt="Iteration 4 Recover Code Screen"  width="189"/> 
    <img style="margin: 20px 0" src="images/recoverCode_invalidInput.png" alt="Iteration 4 Recover Code Invalid Input"  width="189"/> 
    <img style="margin: 20px 0" src="images/recoverCode_validInput.png" alt="Iteration 4 Recover Code Valid Input"  width="189"/> 
    <img style="margin: 20px 0" src="images/bluetooth_iteration4.png" alt="Iteration 4 Bluetooth Screen"  width="189" />
    <img style="margin: 20px 0" src="images/notCheckedIn_iteration4.png" alt="Iteration 4 Not Checked In Screen"  width="189"/> 
    <img style="margin: 20px 0" src="images/selected_iteration4.png" alt="Iteration 4 Selected User Screen"  width="189" />
    <img style="margin: 20px 0" src="images/notSelected_iteration4.png" alt="Iteration 4 Not Selected User Screen"  width="189" />
</div>


</br> </br>
All the increments described above can also be checked out [here](https://github.com/softeng-feup/open-cx-bitx/releases)

---
## Test

### Test Plan

We consider the testing phase a really important one. Given that, we plan to test all the features that we intend to implement:
* Login
* Help
* Code Recovery
* Notifications
* Automatic Check In
* Ticket Acquisition
* Bluetooth detection

###  Test Case Specifications

We decided to implement tests for only three of the features mentioned in our plan given that the main purpose of making this automated tests were to learn how to work with gherkin. 

As visible below, all of the three chosen features passed the developed tests. For each of this feature, we developed three step definitions (Given, When and Then conditions).

We consider the use of gherkin (and the automation of the acceptance tests itself) a really useful tool to apply in future projects in order to help to determine if a certain feature is actually completed with success.  

#### User Story #1 Login

The definition of this user story (and the respective acceptance test) can be found [here](#User-Story-#1)

<img alt="Test Log for Login" src="./images/loginTestLog.png" width="1000">

#### User Story #2 Help

The definition of this user story (and the respective acceptance test) can be found [here](#User-story-#2)

<img alt="Test Log for Help" src="./images/helpTestLog.png" width="1000">

#### User Story #3 Code Recovery

The definition of this user story (and the respective acceptance test) can be found [here](#User-story-#3)

<img alt="Test Log for Code Recovery" src="./images/codeRecoveryTestLog.png" width="1000">

The code for the automated acceptance tests that were made can be found [here](https://github.com/softeng-feup/open-cx-bitx/tree/master/botx_app/test)

---
## Configuration and change management

For the configuration and change management we planned a simple approach for our project. We tried to follow the github flow by using tags and releases for each iteration. 

In retrospective, we wished we had realized the value of branches and pull requests earlier. We now understand that they are important to guarantee control and maintain the integrity of the project. 

However, the fact that we are now (in iteration #5) working with those tools is really useful so that we can learn more from this and apply it to future projects.

---

## Project management

For project management, our group is using Trello. You can find our Trello board in the following link: https://trello.com/invite/b/8T9XmeIY/820dd8f2fab87c8ef924e8e77fc6bda1/botx

---

## Evolution - contributions to open-cx

In iteration #5 we were assigned an open issue in the open-cx project. This issue consists in creating a button for the participant to be able to click and be checked in. </br>
For this issue we developed the following:
* **Bottom Tab Navigation** (the menu mentioned in the slides provided didn't exist yet)
* Button to **check in**
* Integration of the **QR Code Generator** so that the user can receive their goodies
* **QR Code Scanner** so the people that deliver the goodie bags can confirm if that participant has already received a goodie bag or not (this scanner was also integrated in the helpScreen because we had no indication if this scanner were to be used inside the app but with an admin account or if it will be a standalone application)
* Changed the **participant model** to include two booleans: one to check if the user is checked in and another to check if the user has received the gift bag
* Implemented the corresponding **backend** (to check in the user, verify if the user is checked in, say that the participant has received the goodie bag and check if the user has already received the bag)

The backend feature could not be tested because we were not able to connect with mongoDB. Given that, (and to guarantee that the frontend could run without errors) we decided to comment the backend calls made by the frontend.

## Last changes in the report

In the last week we made some major changes to our report so that it would be as complete and accurate as possible. Topics we've changed:
* Use cases and diagram
* User stories
* Architecture and Design
* Implementation
* Test
* Evolution - contributions to open-cx