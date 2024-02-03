import subprocess

def parse_assembly_line(line):
    parts = line.strip().split(',') 
    if len(parts) != 2:
        raise ValueError("Invalid assembly line format")

    command, value = parts
    command = command.strip().upper()
    value = int(value.strip())
    if command not in ('MOV', 'TURN'):
        raise ValueError("Invalid command")

    return command, value

def generate_matrix(instructions, matrix_size):
    matrix = [['\U0001F333' for _ in range(matrix_size)] for _ in range(matrix_size)]
    x, y, direction = matrix_size - 1, 0, 180  # Set initial position to bottom left corner looking up

    for command, value in instructions:
        if command == 'MOV':
            distance = value
            direction = (direction + 0) % 360
        elif command == 'TURN':
            distance = 0
            direction = (direction + value) % 360

        for _ in range(distance):
            matrix[x][y] = '\U0001F986'  # Mark the robot's path

            x = (x + 1) % matrix_size if direction == 0 else x
            y = (y - 1) % matrix_size if direction == 90 else y
            x = (x - 1) % matrix_size if direction == 180 else x
            y = (y + 1) % matrix_size if direction == 270 else y

        matrix[x][y] = '\U0001F916'# Mark the robot's final position

    return matrix

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

    matrix = generate_matrix(instructions, matrix_size)
    
    for row in matrix:
        print(' '.join(row))

    # Open a new terminal tab and display the matrix
    subprocess.run(['gnome-terminal', '--', 'bash', '-c', 'python3 display_matrix.py'])




