'''
This code implements Conway's Game of Life using Cython to improve efficiency.
Conway's Game of Life is a cellular automaton devised by the British mathematician John Horton Conway in 1970.
'''

# Definition of the update function that performs a board state update
def update(lattice):
    # Calculate the size of the board by subtracting 2 from the original board size
    box_length = len(lattice) - 2
    # Create a new matrix to store the updated state of the board
    lattice_new = [[0 for _ in range(box_length + 2)] for _ in range(box_length + 2)]
    # Iterate over all cells of the board
    for i in range(1, box_length + 1):
        for j in range(1, box_length + 1):
            # Update the state of the cell in the new matrix using the update_rule function
            lattice_new[i][j] = update_rule(lattice, i, j)
    # Return the updated board
    return lattice_new

# Definition of the update_rule function that applies Conway's Game of Life rules to a specific cell
def update_rule(lattice, i, j):
    # Calculate the number of live neighbors of the current cell
    n_neigh = lattice[i + 1][j] + lattice[i][j + 1] + lattice[i + 1][j + 1] + \
               lattice[i + 1][j - 1] + lattice[i - 1][j] + lattice[i][j - 1] + \
               lattice[i - 1][j + 1] + lattice[i - 1][j - 1]
    # Apply Conway's Game of Life rules to determine the new state of the cell
    if (lattice[i][j] == 1) and (n_neigh in [2, 3]):
        return 1
    elif lattice[i][j] == 1:
        return 0
    elif (lattice[i][j] == 0) and (n_neigh == 3):
        return 1
    else:
        return 0