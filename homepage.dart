import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pacman/path.dart';
import 'package:pacman/pixel.dart';
import 'package:pacman/player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int numberInRow = 11;
  late int numberOfSquares; // Declare as late to initialize it in initState
  late int player;
  bool gameStarted = false;
  bool mouthClosed = true;
  static List<int> barries = [
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    22,
    33,
    44,
    55,
    66,
    77,
    88,
    99,
    110,
    121,
    132,
    143,
    154,
    165,
    176,
    177,
    178,
    179,
    180,
    181,
    182,
    183,
    184,
    185,
    186,
    175,
    164,
    153,
    142,
    131,
    120,
    109,
    98,
    87,
    76,
    65,
    54,
    43,
    32,
    21,
    78,
    79,
    80,
    100,
    101,
    102,
    84,
    85,
    86,
    106,
    107,
    108,
    24,
    35,
    46,
    57,
    30,
    41,
    52,
    63,
    81,
    70,
    59,
    61,
    72,
    83,
    26,
    28,
    37,
    38,
    39,
    123,
    134,
    145,
    156,
    129,
    140,
    151,
    162,
    103,
    114,
    125,
    105,
    116,
    127,
    147,
    148,
    149,
    158,
    160
  ];
 static List<int>food=[];
  String direction = "right"; // Giving direction to swipe on screen as we touch on it

  @override
  void initState() {
    super.initState();
    numberOfSquares = numberInRow * 17;
    player = numberInRow * 15 + 1;
  }

  void startGame() {
    moveGhost();
    gameStarted=true;
    getfood();
    Timer.periodic(Duration(milliseconds: 150), (timer) {


      if(food.contains(player)){
        food.remove(player);//basically removes the yellow dots which are considered as foods
      }

      switch(direction){
        case"left":
          moveLeft();

          break;
        case"right":
          moveRight();

          break;
        case"up":
          moveUp();

          break;
        case"down":
          moveDown();

          break;

      }


    });
  }
  String ghostDirection="left";
  void moveGhost() {
    // // Logic for moving the ghost
    // // For example, you can randomly select a direction for the ghost to move
    // // Here's a basic example using the Random class to randomly select a direction
    // Random random = Random();
    // int randomNumber = random.nextInt(4); // Generates a random number between 0 and 3
    // switch (randomNumber) {
    //   case 0:
    //     if (!barries.contains(player - 1)) {
    //       // Move the ghost left if possible
    //       setState(() {
    //         // Update the position of the ghost
    //         player--;
    //       });
    //     }
    //     break;
    //   case 1:
    //     if (!barries.contains(player + 1)) {
    //       // Move the ghost right if possible
    //       setState(() {
    //         // Update the position of the ghost
    //         player++;
    //       });
    //     }
    //     break;
    //   case 2:
    //     if (!barries.contains(player - numberInRow)) {
    //       // Move the ghost up if possible
    //       setState(() {
    //         // Update the position of the ghost
    //         player -= numberInRow;
    //       });
    //     }
    //     break;
    //   case 3:
    //     if (!barries.contains(player + numberInRow)) {
    //       // Move the ghost down if possible
    //       setState(() {
    //         // Update the position of the ghost
    //         player += numberInRow;
    //       });
    //     }
    //     break;
    //   default:
    //     break;
    // }
  }

  void getfood(){//this function will add the food which are not the barries basically which are not blur oness
    for(int i=0;i<numberOfSquares;i++){
      if(!barries.contains(i)){
        food.add(i);

      }
    }

  }

  void moveLeft(){
    if (!barries.contains(player - 1)) {//by subtracting 1 we will go to left
      // Barriers: the walls; when it is on the player position, it will return false, and pacman will hit the wall
      setState(() {
        player--; // Adding 1 to the integer
      });
    }

  }
  void moveRight(){
    if (!barries.contains(player +1)) {
      // Barriers: the walls; when it is on the player position, it will return false, and pacman will hit the wall
      setState(() {
        player++; // Adding 1 to the integer
      });
    }

  }
  void moveUp(){
    if (!barries.contains(player -numberInRow)) {
      // Barriers: the walls; when it is on the player position, it will return false, and pacman will hit the wall
      setState(() {
        player-=numberInRow; // Adding 1 to the integer
      });
    }

  }
  void moveDown(){
    if (!barries.contains(player +numberInRow)) {
      // Barriers: the walls; when it is on the player position, it will return false, and pacman will hit the wall
      setState(() {
        player +=numberInRow; // Adding 1 to the integer
      });
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.delta.dy > 0) {
                  direction = "down";
                } else if (details.delta.dy < 0) {
                  direction = "up";
                }
                print(direction);
              },
              onHorizontalDragUpdate: (details){
                if (details.delta.dx > 0) {
                  direction = "right";
                } else if (details.delta.dx < 0) {
                  direction = "left";
                }

              },
              child: Container(
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: numberOfSquares,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: numberInRow,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    if(mouthClosed){
                      return Padding(padding:EdgeInsets.all(4) ,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          shape: BoxShape.circle
                        ),
                      ),);
                    }
                   else if (player == index) {

                      switch(direction){
                        case"left":
                          return Transform.rotate(angle: pi,child: MyPlayer(),);
                          break;

                        case"right":
                         return  MyPlayer();
                          break;
                        case"up":
                          return Transform.rotate(angle:3* pi/2,child: MyPlayer(),);//to face the direction of the player where he is moving
                          break;
                        case"down":
                          return Transform.rotate(angle: pi/2,child: MyPlayer(),);
                          break;
                        default:return MyPlayer();
                      }



                    } else if (barries.contains(index)) {
                      return MyPixel(
                          innercolor: Colors.blue[900] ?? Colors.black,
                          outercolor: Colors.blue[900] ?? Colors.black,
                          child: Text(index.toString()));
                    } else {
                      return MyPath(
                          innercolor: Colors.yellow,
                          outercolor: Colors.black,
                          child: Text(index.toString()));
                    }
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Score:",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  GestureDetector(
                    onTap: startGame,
                    child: Text(
                      "P L A Y",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
