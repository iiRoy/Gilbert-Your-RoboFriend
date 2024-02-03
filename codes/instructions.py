import subprocess
import sys

num_matrix = int(sys.argv[1])

def create_window_with_emojis(emoji_matrix, direction):
    # Convert matrix to string representation
    emoji_text = '\\n'.join([' '.join(row) for row in emoji_matrix])

    # Convert direction to compass direction
    compass_direction = {
        0: "South!",
        90: "West!",
        180: "North!",
        270: "East!"
    }.get(direction, "Unknown")

    # Run tkinter code in a separate process
    subprocess.Popen(['python', '-c', f"""
import tkinter as tk
root = tk.Tk()
root.title('GILBERT - MATRIX {num_matrix}')
matrix_label = tk.Label(root, text="{emoji_text}", font=('Arial', 30))
matrix_label.pack()
direction_label = tk.Label(root, text="Gilbert is looking to the {compass_direction}", font=('Arial', 20, 'bold'))
direction_label.pack()
root.mainloop()
"""])

def parse_assembly_line(line):
    parts = line.strip().split(',') 
    if len(parts) != 2:
        raise ValueError('Invalid assembly line format')

    command, value = parts
    command = command.strip().upper()
    value = int(value.strip())
    if command not in ('MOV', 'TURN'):
        raise ValueError('Invalid command')

    return command, value

def generate_matrix(instructions, matrix_size):
    matrix = [['\U0001F333' for _ in range(matrix_size)] for _ in range(matrix_size)]
    x, y, direction = matrix_size - 1, 0, 180  # Set initial position to bottom left corner facing North

    if not instructions:
        matrix[x][y] = '\U0001F916'  # If no instructions, robot starts at the bottom left corner facing up

    for command, value in instructions:
        if command == 'MOV':
            distance = value
            direction = (direction + 0) % 360
        elif command == 'TURN':
            distance = 0
            direction = (direction + value) % 360

        for _ in range(distance):
            matrix[x][y] = '\U0001F518'  # Mark the robot's path

            x = (x + 1) % matrix_size if direction == 0 else x
            y = (y - 1) % matrix_size if direction == 90 else y
            x = (x - 1) % matrix_size if direction == 180 else x
            y = (y + 1) % matrix_size if direction == 270 else y

        matrix[x][y] = '\U0001F916'  # Mark the robot's final position

    return matrix, direction

if __name__ == "__main__":
    matrix_size = 12  # Adjust the matrix size as needed
    instructions = []

    with open("instructions.asm", "r") as file:
        for line in file:
            try:
                command, value = parse_assembly_line(line)
                instructions.append((command, value))
            except ValueError as e:
                print(f"Error: {e}")

    matrix, direction = generate_matrix(instructions, matrix_size)
    create_window_with_emojis(matrix, direction)

    # The script will end here, and the window will remain open.