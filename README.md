# pin_robot
Description
The application is a simulation of a toy robot moving on a square tabletop, of dimensions 5x5. Having a CLI option and also a web version.

There are no other obstructions on the table surface.

The robot is free to roam around the surface of the table, but must be prevented from falling to destruction. Any movement that would result in the robot falling from the table must be prevented, however further valid movement commands must still be allowed.


## How to run
- Download project from repository with command: git clone https://github.com/Diogoazvg/pin_robot.git.
- Install ruby 3.2.0.
- Go to project path `/pin_robot`.
- Execute command: bundle install for install dependencies.
- Run unity test with rspec.

### Important: it is necessary to respect this structure, including the format of PLACE:0,0,NORTH, the values can be changed to the accepted values, however maintaining its structure. Invalid values will be ignored in the execution.
  ### Valid values:
  Format PLACE:
  ``` ruby
     PLACE:1,0,NORTH #From 0 to 4 for x and y and NORTH SOUTH EAST WEST for f.
  ```
  Other values:   
  `NORTH SOUTH EAST WEST REPORT MOVE LEFT RIGHT`   
  Complete command must have string:    
  `"PLACE:1,0,NORTH MOVE RIGHT LEFT MOVE MOVE REPORT MOVE"`   
  REPORT defines the quantity that will be reported the position of the robot.
  
## There are two modes of test software.
  ### Using Graphql requests with a request client.    
  1 - In path of project must have execute `rails s` for start Rails server.   
  2 - Must have a post to `localhost:3000/graphql`    
  3 - Mutation example:
  
    ```
      mutation{
        movementRobot(
          input:{
            movementCommands: "PLACE:1,0,NORTH MOVE RIGHT LEFT MOVE MOVE REPORT MOVE 1 355 REPORT MOVE"
          }  
        ){
          reportMovemetsRobot
        }
      }
    ```
Example at Insominia:
![image](https://user-images.githubusercontent.com/4728989/230628226-fca7e592-7227-463b-a6f1-52e1b72a24e8.png)

  ### Running by console rails.      
  1 - Run command `rails c` in path of project.         
  2 - Run the organizer that runs the robot movement flow.       
  - Example command: 
    ```ruby
      Robot::ToWalkRobotOrganizer.call(values: "PLACE:1,0,NORTH REPORT MOVE REPORT MOVE").reports
    ```
  - Example result: 
    ```ruby
      ["1,0,NORTH", "1,1,NORTH", "1,2,NORTH"]
    ```
