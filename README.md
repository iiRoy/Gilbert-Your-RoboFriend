# Gilbert-Your-RoboFriend
## What is this project about?
When talking about industry, intelligent manifacturing is important for the correct development of tasks, from moving boxes to the mantainance of important servers around the globe. Gilbert was made with the idea of implementing a system that can give a hand to the industry, simulating a virtual environment for the robot to interact with the user and with the created sandbox, by using a basic Context Free Grammar (CFG) that compose the majority of its artificial intelligence.

This virtual robot understands simple phrases to transform them into real actions by translating the sentences into functional orders by a lexical and a syntactical analyzer, by then projecting the result of the commands on a virtual sandbox supported by a Trinker simple environment, which reads all the files containing a simplified version of the orders given by the users to Gilbert o an ".asm".

### Gilbert in the Industry
Nowadays automatization is important in process and subprocess of the daily tasks of an enterprise. Gilbert is a solution for those automatizations, giving the possibility to manage robots from a place, and let them do the work, optimizing the time, and the energy of a team when producing and creating new products.

As well, Gilbert can be used in the educational process, where children can learn basic English grammar by using the bot, giving interactive lessons, as well an introduction to computation and automatization.

## How was created?
Gilbert was created with the idea to develop knowledge by the implementation of syntactical and lexical analyzers. For this, we created 4 main files, which give support to our robot by functioning like a translator.

Our lexical analyzer was develop in "LEX", in the file named "instructions.l". In there we defined all our tokens and alphabet to use by the user.

Our syntactical analyzer was develop in "YACC", in the file named "instructions.y". In there we defined all our interactions with the tokens, and our CFG that will determine the rules the tokens should follow for the translation of the instructions.

Our CPU, which will handle the creation of the virtual environment of the robot, the reading of the translated instructions of the user, and the handler and processer of those instructions, was develop in "PYTHON", in the file named "instructions.py". In there you can find a subprocess that will create a Trinker environment for the visual representation of the bot's actions.

### What is the task of each file?
We can find 8 main files when we run correctly our program.
- instructions: This is an executable file. You should run it on the terminal.
- instructions.l: This file contains all the lexical analyzer logic.
- instructions.py: This file contains all the CPU logic.
- instructions.y: This file contains all the syntactical analyzer (parser) logic.
- lex.yy.c: This file contains all the lexical analyzer logic transformed into a c type file.
- y.tab.c: This file contains all the parser logic transformed into a c type file.
- y.tab.c: Define the associations of tokens names, as well the beggining and the end of the integers with some significance, so the parser can be generated.

## How to use it?
### How to run it?
1.- Download the files on a LINUX emulator, or a LINUX system.
2.- Open the terminal and search the location of the downloaded files with "cd".
3.- Run "lex instructions.l".
4.- Run "yacc -d instructions.y".
5.- Run "gcc -o instructions y.tab.c lex.yy.c -ll". (You can change the name of instructions to whatever you want your program to be named).
6.- Run "./instructions". (If you changed the name of your executable, also change it to that on this step).

### How does the grammar, and alphabet works?
When talking to Gilbert you need to be specific on what you need. Since this version can be quite limited, we invite you to improve the CFG and the alphabet of this program in order to improve the functionable features of the project.

#### What's the alphabet?
NOUNS - Gilbert, Gentleman, Robot - Ways to refer to Gilbert.
POLITE - please, kindly, mind to, pretty please, pretty kindly, pretty mind to - Ways to be polite to Gilbert.
PETITION - would you [POLITE], will you [POLITE], can you [POLITE] - Ways to ask something to Gilbert.
VERBS - move, turn, project - Ways to give an order to Gilbert. Move will move either 1 (if it's not specific) or the specified spaces. Turn will turn either 90° (if it's not specific) or the specified degrees (only accepts 90°, 180°, 270°, and 360°). Project will run the CPU to visualize the orders of the bot. (Note that it will only project after an INPUT, and will project all the orders before the stated project. If you put a project in the middle of a statement, it will read all the orders of that INPUT and then project all the given orders by the moment. When closing the program, all the MATRIX created by the CPU will automatically close [this rule doesn't count in "read file" mode]).
MOVING - QUANTITY, QUANTITY BLOCKS, QUANTITY DIRECTION, QUANTITY BLOCKS DIRECTION - The [QUANTITY] will be always numerical. The [BLOCKS] can be either defined as "block"/"space" (if there's multiple, or none number of BLOCKS to move, remember to change it to "blocks"/"spaces"). The [DIRECTION] can be either defined as "forward", "straight", or "ahead" if you want to go straight the direction Gilbert's looking, or "back", and "backward" if you want to go the opposite way the direction Gilbert's looking. (Note that we don't allow the user to put "backwards", since this program only accepts American English).
TURNING - QUANTITY - The [QUANTITY] can be either numerical (always following the rules established on VERBS) or text. If it's a number, it should always have a "°" sign (whether it's text or symbol [ex. "90°" / "90 degrees"]. If it's a text, you should use right to turn 90°, around to turn 180°, or left to turn 360° [ex. "turn right", "turn around", "turn left"].
CONJUCTIONS - and, then, and then, Also - They are used to join 2 actions.
PUNCTUATION - !, ?, ., , - Used to state either the end of a sentence, or the union of conjuctions.

### What are the grammatical rules?
CONJUCTIONS - There's certain rules to use conjuctions. Wheather it's correct to just left the sentence without a conjuction to join 2 orders (only with a comma) [ex. "move, turn"], if we want to join them with an "and", "then", or "and then", we need to add a comma before the previous action [ex. "move, and turn" / "move, then turn" / "move, and then turn"]. If we want to use Also, we need to add a period to the previous action, as well a comma after the statement of Also [ex. "move. Also, turn"]. We are allowed to give a petition, or to be polite after an Also, however if you are not, it's fine for the bot meanwhile you are at the start of your sentence [ex. "Robot please move. Also turn." / "Robot please move. Also please turn."].
PUNCTUATION - You should always end with a ".", "?", or "!". The program doesn't detects if it's a question, or a statement, so either of them is fine. As well, you should follow the rules stated by the conjuctions previously mentioned. As well you may or not add a comma after a NOUN.
SPECIAL SIGNS - You may replace "and" with "&".
SPACES - The program doesn't count any spaces, so if you put 5 of those, the robot will read it as one.

## Example of INPUTS.
### Accepted INPUTS
- "Gilbert, would you pretty please turn, move?".
- "Robot, will you please move 3 blocks, and turn 90°.".
- "Gentleman pretty please move 4 spaces back, then turn right. Also, project!".
- "Gilbert please move forward, and then turn around. Also, could you pretty please move 4, and project?".
- "Robot, please move straight, then turn left. Also, pretty please project, and turn right.".

### Denied INPUTS
- "Gilbert, Would you pretty please turn, move?".
- "Robot, will you please move 3 blocks and turn 90°".
- "Gentleman move 4 spaces back, then turn right. Also, project!".
- "Gilbert, plear move forward, and turn around, also, could you pretty please move 4, and project?".
- Robot, please move straight, then turn left. Also, pretty please project it, and turn right.".
