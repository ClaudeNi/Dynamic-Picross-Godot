Dynamic Picross Game  

https://claude-ni.itch.io/picross

## A Picross game made using Godot 3.5

![Banner](https://raw.githubusercontent.com/ClaudeNi/Dynamic-Picross-Godot/main/readme%20imgs/picross%20banner.png)

This little project was a challenge I set up for myself to take an idea and create it, and my idea was to develop a picross game that can dynamically read a black and white image of a picross puzzle and then load that into the game for the player to play it.
And it was a success, you can play the game with 6 levels created by me, 3 10x10 and 3 15x15 levels.

The game only has a couple of scenes:
- The main menu screen
- The level select screen
- The level screen
- The options screen

The main menu itself is rather simple, it just has a couple buttons and the title screen itself. Click "Start Game" will take you to the level select screen.
![Main Menu](https://raw.githubusercontent.com/ClaudeNi/Dynamic-Picross-Godot/main/readme%20imgs/1%20main_menu.png)

The level select screen has all 6 puzzles that I created, hidden at the start. Pressing one of them will take you to the level screen with the select puzzle loaded. After you complete it, the level select screen will update the question mark with the image itself and the name of the puzzle.
![Level Select Screen](https://raw.githubusercontent.com/ClaudeNi/Dynamic-Picross-Godot/main/readme%20imgs/2%20level_select.png)

The level screen itself where I used a tilemap to visualize the cells for both the numbers and the puzzle. Left clicking on the white cells will fill them and right clicking will mark an X. Clicking either the filled or x marked cells will clear them.
![Level Screen](https://raw.githubusercontent.com/ClaudeNi/Dynamic-Picross-Godot/main/readme%20imgs/3%20level.png)

In the options screen you can mute/unmute and delete your save data if you choose to do so, and it also includes some crediting for the tracks I used.
![Options Screen](https://raw.githubusercontent.com/ClaudeNi/Dynamic-Picross-Godot/main/readme%20imgs/4%20options_screen.png)
