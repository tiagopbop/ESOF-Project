# QuickFork Development Report

Welcome to the documentation pages of the QuickFork!

You can find here details about the QuickFork, from a high-level vision to low-level implementation decisions, a kind of Software Development Report, organized by type of activities:

* [Business modeling](#Business-Modelling)
  * [Product Vision](#Product-Vision)
  * [Features and Assumptions](#Features-and-Assumptions)
  * [Elevator Pitch](#Elevator-pitch)
* [Requirements](#Requirements)
  * [Domain model](#Domain-model)
* [Architecture and Design](#Architecture-And-Design)
  * [Logical architecture](#Logical-Architecture)
  * [Physical architecture](#Physical-Architecture)
  * [Vertical prototype](#Vertical-Prototype)
* [Project management](#Project-Management)

Contributions are expected to be made exclusively by the initial team, but we may open them to the community, after the course, in all areas and topics: requirements, technologies, development, experimentation, testing, etc.

Please contact us!

Thank you!

*António Abílio* (up202205469@up.pt)

*Gonçalo Nunes* (up202205538@up.pt)

*Tiago Pinheiro* (up202207890@up.pt)

*Tiago Rocha* (up202206232@up.pt)

*Vanessa Queirós* (up202207919@up.pt)

---
## Business Modelling

### Product Vision

Skip the line, save time. An app designed to transform the canteen experience at FEUP by simplifying the queuing process. Our vision is to create an organized and efficient app that’s not only user-friendly but also allows students to optimize their time.

### Features and Assumptions
- Buy canteen tickets - Purchase canteen tickets effortlessly without needing physical copies and waiting in the line.
- Consult canteen menus - Easily view menus for specific days to decide on purchasing tickets.
- Payment with card and MB Way - Pay for tickets using either card or MB Way, ensuring a smooth transaction process.
- Save payment methods - Store your preferred payment methods for future purchases, to improve the buying process.
- Consult bought meals - Check previously purchased meals to stay organized and keep track of your history.
- Validation of tickets - Enable workers to validate tickets within the app, ensuring a safe and efficient process.
- Login with SIGARRA credentials - Log in using SIGARRA credentials, simplifying access and providing a faster login experience for users.

### Elevator Pitch
Hi! I'm part of a group of students that is developing an app that will allow for faster lines at FEUP's canteen. Currently if you go to the canteen you'll find that most of the time spent before being able to get your food is waiting in the queue and buying the food's ticket.

Our flutter app provides the solution to this while being easy to use. Just use your already existing Sigarra's login and associate your prefered payment method, either using MbWay or using your debit/credit card. After this you'll be able to access our shop from where you can select which ticket you wanna buy. Finally, in the canteen, when you're asked to, just click the bought ticket and show it.

That's it, if you are a user of FEUP's canteen you'll surely love our app.

"So, how much time do you spend on the queues?"


## Requirements

### Domain model

<p align="center" justify="center">
  <img src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC18T2/blob/4d7cdbd910a2e96782669d082f4f9a44601ae377/images/DomainModel.png?raw=true"/>
</p>

The user can be either a student or an employee. From the student it is relevant to know the year and the degree they are on. As for the employee, their function must be known.

A user can buy a ticket for a specific meal, which has a type (meat, fish, or vegetarian), a description, a boolean to check if it is a lunch or dinner, a boolean to check if it is a full dish or only the main dish and a date for when the dish is being served.

For every ticket there is an ID, a price that depends on the user (student or employee) and the fullDish boolean, and a boolean to check if it has already been used. The ticket can only exist if it has been paid for.

One user can buy many tickets, related to the user by their UpNumber, name and email address.

The ticket can be bought by the user using MbWay or a credit card, and it needs to be validated by the employee.

## Architecture and Design

### Logical architecture

<p align="center" justify="center">
  <img src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC18T2/blob/becca77738264bed0cfa3b8cc3a72b8dd9e52ebc/images/LogicalView.png?raw=true"/>
</p>

App UI is used to view the application pages;

App Business Logic is used to manage and alter the user's data

App Database Scheme is where some of the data of the app is stored

Sigarra is an external database that has the information about the student/worker.

Payment Gateway is the method that allows the transaction to occur between the bank of the buyer and the canteen shop.

### Physical architecture

<p align="center" justify="center">
  <img src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC18T2/blob/becca77738264bed0cfa3b8cc3a72b8dd9e52ebc/images/DeploymentView.png?raw=true"/>
</p>

The physical architecture diagram shows five nodes that represent the physical components of our app and how they are connected.

The first node is the "Students SmartPhone", represented by the 'Application (Flutter)' component, which is used to access the app using the 'App UI'.

The second one is the "Workers SmartPhone", represented by the 'Application (Flutter)' component, which is used to access the app using the 'App UI' and 'Ticket Checker UI'.

The third is the "Application Server" that makes the connection between the UIs and logical and checking services, which then connects to the Database, while also accessing the required external entities.

The fourth node is the "Bank Server", represented by the 'Bank (API)', which is used to access external information related to the user's bank account.

The fifth one is the "Sigarra Server", represented by the 'Sigarra (API)', which is used to access external information related to the user's Sigarra account.

### Vertical prototype
<p align="center" justify="center">
  <img src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC18T2/blob/d8b1a24db565edbf4bbcbb71a105e8953603d12f/images/Prototype.jpeg?raw=true" width="50%"/>
</p>

A vertical prototype was created with a simple menu, using both flutter and firebase, which will be used later on to keep track of crucial information.

## Project management

* Backlog management: [Github Projects Board](https://github.com/orgs/FEUP-LEIC-ES-2023-24/projects/16)
* Release management:
  * [v0.0.2](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC18T2/releases/tag/apk_release_sprint_0)
  * [v1.0.0](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC18T2/releases/tag/apk_release_sprint_1)
  * [v2.0.0](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC18T2/releases/tag/apk_release_sprint_2)
  * [v3.0.0](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC18T2/releases/tag/release_sprint_3)
* Sprint planning and retrospectives:

### Sprint 0

>   ### Github Projects Board
>  
>   #### Beginning
>   <p align="center" justify="center">
>  <img src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC18T2/blob/74f14b856d2c1c0fc31c95db8e8eca2a86d407c7/images/product_backlog_s0b.png" width="100%"/>
>   </p>
>
>   ### Retrospectives
>
>   This sprint does not add any valuable functions to the app. The current state of the app is a simple menu with simple buttons. We also planned ahead the project, by establishing the workflow.

### Sprint 1

>   ### Github Projects Board
>
>   #### Beginning
>   <p align="center" justify="center">
>  <img src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC18T2/blob/0c7c2824ceb12357423daca9438fc6c4cf733223/images/sprint1_beginning.png" width="100%"/>
>   </p>
>
>   #### End
>   <p align="center" justify="center">
>  <img src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC18T2/blob/0c7c2824ceb12357423daca9438fc6c4cf733223/images/sprint1_end.png" width="100%"/>
>   </p>
>
>   ### Retrospectives
>
>   In this sprint we did:
>   - An interactive menu
>   - The possibility to buy tickets and pay them with a card or MBWay
> 
>   What went well:
>   - We managed to do everything we had planned
>   - Integration between FlutterFlow and Flutter
>
>   What we will do differently:
>   - More meetings during the sprint
>   - Better division of work
>
>   What still puzzles me is:
>   - Working with Flutter
>   - Automation tests
>
>   Team Wishes:
>   - Better time management
>   - Better team work

### Sprint 2

>   ### Github Projects Board
>
>   #### Beginning
>   <p align="center" justify="center">
>  <img src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC18T2/blob/ca04908cb732c5fe4a6bc32e55b32f5154e6fa44/images/sprint2_beginning.png" width="100%"/>
>   </p>
>
>   #### End
>   <p align="center" justify="center">
>  <img src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC18T2/blob/9d4548e1a00298cac6b065506f7e000c0788c2ab/images/sprint2_end.png" width="100%"/>
>   </p>
>
>   ### Retrospectives
>
>   In this sprint we did:
>   - All tickets have a unique QR Code
>   - We added a worker login
>   - We added a page where workers can validate the tickets
>   - The possibility of saving payment methods (MBWay and card)
>
>   What went well:
>   - We managed to do everything we had planned
>   - Division of work
>   - The use of pair programming, improved the efficiency of the group
>
>   What we will do differently:
>   - Manage the time better
>
>   What still puzzles me is:
>   - Unit Tests
>
>   Team Wishes:
>   - Better team communication

### Sprint 3

>   ### Github Projects Board
>
>   #### Beginning
>   <p align="center" justify="center">
>  <img src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC18T2/blob/ceced840dc27bdebbf4181781868f22bc4a677c8/images/sprint3_beginning.png" width="100%"/>
>   </p>
>
>   #### End
>   <p align="center" justify="center">
>  <img src="https://github.com/FEUP-LEIC-ES-2023-24/2LEIC18T2/blob/4d7cdbd910a2e96782669d082f4f9a44601ae377/images/sprint3_end.png" width="100%"/>
>   </p>
>
>   ### Retrospectives
>
>   In this sprint we did:
>   - Possibility to check already bought meals
>   - Highlight the next meal for easier use 
>   - Login with SIGARRA credentials
>   - Visible statistics of purchased meals
>
>   What went well:
>   - We managed to do everything we had planned
>   - Division of work
>   - The use of pair programming, improved the efficiency of the group
>   - We ended all the user-stories proposed in the beginning of this project
>
>   What we will do differently:
>   - More small meetings
>
>   What still puzzles me is:
>   - Unit Tests
>
>   Team Wishes:
>   - Deploy this app in the real world
