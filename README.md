<p align="center">
  <img 
    src="https://github.com/user-attachments/assets/2a621fed-7482-4c64-9884-23f33fd082a4"
    alt="Volca Popocatépetl Risk Logo" 
    width="700"
  />
</p>

**Gilbert — Your Robo-Friend** is a natural-language command interpreter for a virtual robot. The project uses **Lex**, **YACC**, **C**, and **Python** to translate simple English instructions into robot movement commands and then visualize Gilbert's path inside a simulated matrix environment.

The main goal of the project is to demonstrate how lexical and syntactic analyzers can process human-like commands and transform them into structured actions that a robot can execute.

> [!NOTE]
> This project was created as an academic compiler/construction project focused on lexical analysis, syntax interpretation, context-free grammar, and basic robot movement simulation.

---

## Overview

Gilbert is a virtual robot that understands a limited set of polite English commands such as:

```text
Robot, please move 3 blocks.
Gilbert, would you please turn 180°?
Gentleman, can you pretty please move 1 block back?
```

The system analyzes the sentence, validates whether it follows the grammar rules, translates the accepted instruction into a simplified assembly-like format, and optionally projects the robot's movement in a visual matrix using Python and Tkinter.

The project includes:

- A lexical analyzer created with **Lex**.
- A syntax interpreter created with **YACC**.
- A Python CPU simulation for robot movement.
- A command grammar based on natural-language petitions.
- File-based and terminal-based input modes.
- A generated `instructions.asm` file.
- Matrix visualization using emojis.
- Academic documentation and execution evidence.

> [!IMPORTANT]
> Gilbert does not understand unrestricted natural language. It understands only the vocabulary and grammar defined inside the Lex and YACC files.

---

## Project Structure

```text
Gilbert-Your-RoboFriend/
│
├── codes/
│   ├── instructions.l
│   ├── instructions.y
│   ├── instructions.py
│   └── instructions.txt
│
├── docs/
│   ├── Ejecucion_Purebas.mp4
│   ├── Gilbert.pdf
│   └── Gilbert_ProyectoFinal.pdf
│
├── .gitignore
├── LICENSE
└── README.md
```

---

## File Description

| File | Description |
|---|---|
| `codes/instructions.l` | Lex file containing the lexical analyzer, tokens, and accepted words. |
| `codes/instructions.y` | YACC file containing the grammar rules, parser logic, menu system, and command translation logic. |
| `codes/instructions.py` | Python CPU simulation that reads `instructions.asm` and displays Gilbert's path in a matrix. |
| `codes/instructions.txt` | Example input file containing accepted and rejected test commands. |
| `docs/Ejecucion_Purebas.mp4` | Execution video showing tests of the project. |
| `docs/Gilbert.pdf` | Presentation-style documentation explaining the problem, tokens, grammar, CPU, and results. |
| `docs/Gilbert_ProyectoFinal.pdf` | Full academic report describing the project, implementation, grammar, and conclusions. |
| `LICENSE` | MIT License for the project. |

---

## How It Works

The project works as a small compiler-style pipeline.

```text
User sentence
     ↓
Lexical analyzer
     ↓
Syntax interpreter
     ↓
Generated movement instructions
     ↓
instructions.asm
     ↓
Python CPU simulation
     ↓
Matrix visualization
```

### 1. Lexical Analysis

The Lex file, `instructions.l`, identifies valid tokens such as:

- Robot names
- Polite phrases
- Petitions
- Movement verbs
- Turn commands
- Directions
- Numbers
- Punctuation
- Conjunctions

If a word or symbol does not match the accepted vocabulary, it is treated as an invalid or unknown token.

---

### 2. Syntax Interpretation

The YACC file, `instructions.y`, defines the grammar rules that accepted sentences must follow.

The parser verifies whether the sentence has a valid structure, such as:

```text
ROBOT + ASK + VERB + SIGN
```

or more complex chained instructions such as:

```text
Robot, please move 3 blocks, and then turn right.
```

If the sentence is accepted, the parser translates it into movement instructions.

If the sentence is rejected, Gilbert responds that he did not understand the request.

---

### 3. Instruction Translation

Accepted instructions are written into a generated file:

```text
instructions.asm
```

The generated format is simple and assembly-like.

Example:

```text
MOV, 3
TURN, 90
MOV, 1
```

---

### 4. Python CPU Simulation

The Python file, `instructions.py`, reads `instructions.asm`, processes each command, and generates a visual matrix.

The matrix uses emoji symbols to represent:

| Symbol | Meaning |
|---|---|
| 🤖 | Gilbert's final position |
| 🔘 | Gilbert's path |
| 🌳 | Empty matrix space / environment |

The Python script also displays the direction Gilbert is facing after executing the commands.

---

## Requirements

To run this project, you need a Linux-based environment or a Linux emulator.

Recommended options:

- Native Linux
- WSL on Windows
- Linux virtual machine
- macOS with compatible Lex/YACC tools

You also need:

| Tool | Purpose |
|---|---|
| `lex` or `flex` | Generates the lexical analyzer. |
| `yacc` or `bison` | Generates the parser. |
| `gcc` | Compiles the generated C files. |
| `python3` | Runs the CPU and matrix visualization. |
| `tkinter` | Displays the visual matrix window. |

> [!IMPORTANT]
> This project is intended to be compiled and executed from the `codes/` folder.

---

## Installation

Clone the repository:

```bash
git clone https://github.com/iiRoy/Gilbert-Your-RoboFriend.git
```

Enter the project folder:

```bash
cd Gilbert-Your-RoboFriend/codes
```

Install required tools on Debian/Ubuntu-based systems:

```bash
sudo apt update
sudo apt install flex bison gcc python3 python3-tk
```

> [!TIP]
> Some systems use `flex` and `bison` as replacements for `lex` and `yacc`.

---

## Build Instructions

From inside the `codes/` folder, run:

```bash
lex instructions.l
```

Then run:

```bash
yacc -d instructions.y
```

Compile the generated C files:

```bash
gcc -o instructions y.tab.c lex.yy.c -ll
```

If `-ll` does not work on your system, try:

```bash
gcc -o instructions y.tab.c lex.yy.c -lfl
```

After compilation, run:

```bash
./instructions
```

> [!WARNING]
> The generated files `lex.yy.c`, `y.tab.c`, `y.tab.h`, `instructions`, and `instructions.asm` are build/runtime outputs. They may not exist until you compile and run the project.

---

## How to Use

After running:

```bash
./instructions
```

Gilbert displays a terminal menu.

```text
Welcome to Gilbert's menu.

- Press '1' to run Gilbert, and define the instructions by 'instructions.txt'.
- Press '2' to run Gilbert, and define the instructions by terminal.
- Press any other key to exit.
```

### Option 1: Read from File

This mode reads commands from:

```text
instructions.txt
```

Use this mode to test multiple accepted and denied commands automatically.

---

### Option 2: Read from Terminal

This mode lets you type commands directly into the terminal.

To exit terminal mode, press:

```text
CTRL + C
```

> [!NOTE]
> Terminal mode keeps reading commands until you manually stop the program.

---

## Logs

Before running the parser, Gilbert asks whether you want to show action logs.

```text
Would you like to read action logs?
Enter '1' for yes, or any other symbol for no:
```

If logs are enabled, Gilbert prints details such as:

- Movement actions
- Turn actions
- Facing direction
- Matrix projection messages
- Grammar acceptance feedback

---

## Supported Commands

Gilbert understands three main actions:

| Command | Description |
|---|---|
| `move` | Moves Gilbert forward or backward. |
| `turn` | Rotates Gilbert. |
| `project` | Opens a matrix visualization of the executed instructions. |

---

## Accepted Robot Names

Gilbert accepts these subject names:

```text
Robot
Gilbert
Gentleman
```

Examples:

```text
Robot, please move 3.
Gilbert pretty please turn 90°!
Gentleman will you please move 3 blocks?
```

> [!IMPORTANT]
> The accepted names are case-sensitive. For example, `Gilbert` is valid, but `gilbert` may not be accepted.

---

## Polite Language

Gilbert is designed to understand polite requests.

Accepted polite words and structures include:

```text
please
kindly
mind to
pretty please
pretty kindly
pretty mind to
```

Accepted petition structures include:

```text
will you
would you
can you
could you
```

Examples:

```text
Robot, will you please move 3 blocks?
Gilbert, can you pretty please move 1 block back?
Gentleman, could you pretty please turn left!
```

---

## Movement Grammar

Gilbert can move using numeric quantities and optional direction words.

Accepted movement patterns include:

```text
move
move 3
move 3 blocks
move 4 spaces
move forward
move straight
move ahead
move back
move backward
move 2 blocks forward
move 2 blocks back
```

Accepted forward words:

```text
forward
straight
ahead
```

Accepted backward words:

```text
back
backward
```

> [!NOTE]
> The grammar accepts `backward`, but not `backwards`.

---

## Turning Grammar

Gilbert can turn using either direction words or numeric degrees.

Accepted turn commands include:

```text
turn
turn right
turn left
turn around
turn 90°
turn 180°
turn 270°
turn 360°
turn 90 degrees
turn 180 degrees
turn 270 degrees
turn 360 degrees
```

Default behavior:

| Input | Result |
|---|---|
| `turn` | Turns `90°`. |
| `turn right` | Turns `90°`. |
| `turn around` | Turns `180°`. |
| `turn left` | Turns `270°`. |

> [!IMPORTANT]
> Numeric turns only accept `90`, `180`, `270`, and `360`.

---

## Conjunctions and Sentence Chaining

Gilbert supports chained actions using conjunctions and punctuation.

Accepted conjunctions include:

```text
and
then
and then
Also
&
```

Examples:

```text
Robot, please move 3 blocks, and turn 90°.
Gilbert, pretty please move back, and turn 270 degrees.
Robot, would you pretty mind to turn around, move 3 blocks ahead, and then project!
```

When using `Also`, the previous sentence must be closed first.

Example:

```text
Robot please move. Also, turn right.
```

> [!WARNING]
> Punctuation matters. Many rejected sentences fail because they are missing commas, periods, question marks, or exclamation marks.

---

## Punctuation Rules

Accepted sentence endings:

```text
.
?
!
```

Commas are used to separate chained actions.

Examples:

```text
Robot, please move 3 blocks.
Gilbert please move, and then turn right.
Gentleman can you kindly move 3 blocks, then turn right!
```

> [!IMPORTANT]
> Every complete instruction should end with `.`, `?`, or `!`.

---

## Example Accepted Inputs

```text
Gilbert, would you pretty please turn, move?
Robot, will you please move 3 blocks, and turn 90°.
Gentleman pretty please move 4 spaces back, then turn right. Also, project!
Gilbert please move forward, and then turn around. Also, could you pretty please move 4, and project?
Robot, please move straight, then turn left. Also, pretty please project, and turn right.
```

---

## Example Denied Inputs

```text
Gilbert, Would you pretty please turn, move?
Robot, will you please move 3 blocks and turn 90°
Gentleman move 4 spaces back, then turn right. Also, project!
Gilbert, plear move forward, and turn around, also, could you pretty please move 4, and project?
Robot, please move straight, then turn left. Also, pretty please project it, and turn right.
```

Common reasons for rejection:

- Incorrect capitalization.
- Missing punctuation.
- Unsupported words.
- Invalid grammar order.
- Missing polite request structure.
- Invalid turn degree.
- Extra words not defined in the lexer.

---

## Preview

<p align="center">
  <video src="https://github.com/user-attachments/assets/dd86f500-d00f-4a19-a747-a274f8f98578" controls width="700">
    Your browser does not support the video tag.
  </video>
</p>

---

## Generated Files

After building and running the project, these files may be generated:

| File | Description |
|---|---|
| `lex.yy.c` | C file generated by Lex/Flex. |
| `y.tab.c` | C parser file generated by YACC/Bison. |
| `y.tab.h` | Header file generated by YACC/Bison. |
| `instructions` | Compiled executable. |
| `instructions.asm` | Generated movement instructions used by the Python CPU. |

> [!TIP]
> These files are build artifacts and can be safely regenerated from `instructions.l` and `instructions.y`.

---

## Matrix Visualization

When a valid instruction includes:

```text
project
```

Gilbert opens a Tkinter window showing his path in a `10 x 10` matrix.

The visualization is handled by:

```text
instructions.py
```

The Python CPU reads:

```text
instructions.asm
```

and displays:

- Gilbert's path.
- Gilbert's final position.
- Gilbert's final facing direction.

> [!NOTE]
> Multiple `project` commands can open multiple matrix windows.

---

## Documentation

The `docs/` folder includes academic documentation and project evidence.

| File | Description |
|---|---|
| `Gilbert.pdf` | Slide-style explanation of the problem, tokens, grammar, CPU, accepted inputs, denied inputs, and conclusions. |
| `Gilbert_ProyectoFinal.pdf` | Full academic report for the project. |
| `Ejecucion_Purebas.mp4` | Execution video demonstrating project behavior. |

> [!TIP]
> Review the PDFs if you want a deeper explanation of the grammar, tokens, CPU design, and academic context.

---

## Technical Concepts

This project demonstrates:

- Lexical analysis.
- Syntax analysis.
- Context-free grammar.
- Tokenization.
- Parser construction.
- Command interpretation.
- Basic compiler pipeline.
- Assembly-like instruction generation.
- Robot movement simulation.
- Matrix visualization.
- Integration between C and Python.

---

## Academic Context

This project was created for:

```text
Course: TC2037 - Implementación de Métodos Computacionales
Project: Gilbert your Robo-Friend
```

The project explores how lexical and syntactic analyzers can be used to process controlled natural-language instructions for a virtual robot.

---

## Team

| Name | Student ID | Role |
|---|---|---|
| Rodrigo López Guerra | A01737437 | YACC, Python matrix, and Lex coder |
| Valter Alejandro Kuhne Hernández | A01379392 | Python matrix coder |
| Ximena Cantera Reséndiz | A01277310 | Lex coder |

---

## Recommended Repository Details

### Description

```text
Lex/YACC and Python project that interprets polite English commands and translates them into robot movement instructions with matrix visualization.
```

### Topics

```text
lex
yacc
flex
bison
compiler-design
lexical-analysis
syntax-analysis
context-free-grammar
python
c
tkinter
robot-simulation
natural-language-processing
academic-project
```

---

## Troubleshooting

### `lex: command not found`

Install Flex:

```bash
sudo apt install flex
```

Then run:

```bash
lex instructions.l
```

or:

```bash
flex instructions.l
```

---

### `yacc: command not found`

Install Bison:

```bash
sudo apt install bison
```

Then run:

```bash
yacc -d instructions.y
```

or:

```bash
bison -y -d instructions.y
```

---

### `cannot find -ll`

Some Linux distributions do not provide the `-ll` Lex library.

Try compiling with:

```bash
gcc -o instructions y.tab.c lex.yy.c -lfl
```

---

### Tkinter window does not open

Install Tkinter:

```bash
sudo apt install python3-tk
```

Then run the program again.

---

### `instructions.txt` not found

Make sure you are running the executable from inside the `codes/` folder.

Correct location:

```bash
cd Gilbert-Your-RoboFriend/codes
./instructions
```

---

### `instructions.asm` not found

This file is generated automatically after Gilbert accepts valid instructions.

If it does not exist:

1. Run `./instructions`.
2. Enter a valid command.
3. Include `project` if you want to trigger the Python matrix visualization.

---

### My sentence is rejected

Check that:

- The robot name is valid.
- The request is polite.
- The sentence ends with `.`, `?`, or `!`.
- The command uses accepted vocabulary.
- The conjunction punctuation is correct.
- Numeric turns are only `90`, `180`, `270`, or `360`.

---

## Possible Improvements

Future versions could include:

- Support for lowercase robot names.
- More flexible natural-language grammar.
- More movement directions.
- Better error messages explaining why a sentence failed.
- A graphical interface for command input.
- A clearer separation between parser logic and menu logic.
- Support for Windows execution.
- A Makefile for easier compilation.
- Automatic cleanup of generated files.
- Larger or configurable matrix size.
- Obstacles inside the matrix.
- Multiple robot agents.
- Unit tests for accepted and rejected grammar cases.

---

## License

This project is licensed under the **MIT License**.

See the `LICENSE` file for details.

> [!IMPORTANT]
> The MIT License applies to the project source code. Documentation, videos, and other media should be reused with proper attribution.

---

## Disclaimer

This project is an academic simulation and grammar-processing exercise.

It is not a real industrial robot control system and should not be used to control physical robots without additional safety systems, validation, hardware integration, and professional review.

> [!CAUTION]
> Robot movement in this project is simulated in a virtual matrix only.
