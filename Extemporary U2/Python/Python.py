'''
This function takes a lattice and updates it according to the rules defined in the update_rule function.
The update is performed for each cell in the lattice, and the result is a new updated lattice.
'''
def update(lattice):
    # Calculate the length of the lattice box
    box_length = len(lattice) - 2
    # Create a new lattice of the same size as the original, initialized with zeros
    lattice_new = [[0 for _ in range(box_length + 2)] for _ in range(box_length + 2)]
    # Iterate over each cell in the original lattice
    for i in range(1, box_length + 1):
        for j in range(1, box_length + 1):
            # Update the cell in the new lattice based on the rules defined in update_rule
            lattice_new[i][j] = update_rule(lattice, i, j)
    # Return the new updated lattice
    return lattice_new

'''
This function determines the state of a cell in the next iteration based on its current state and the state of its neighbors.
It applies the rules of Conway's Game of Life to determine the new state of the cell.
'''
def update_rule(lattice, i, j):
    # Calculate the number of live neighbors of the current cell
    n_neigh = lattice[i + 1][j] + lattice[i][j + 1] + lattice[i + 1][j + 1] + \
    lattice[i + 1][j - 1] + lattice[i - 1][j] + lattice[i][j - 1] + \
    lattice[i - 1][j + 1] + lattice[i - 1][j - 1]
    # Apply the rules of Conway's Game of Life to determine the new state of the cell
    if (lattice[i][j] == 1) and (n_neigh in [2, 3]):
        return 1  # The cell remains alive
    elif lattice[i][j] == 1:
        return 0  # The cell dies due to overpopulation or loneliness
    elif (lattice[i][j] == 0) and (n_neigh == 3):
        return 1  # A new cell is born in a dead cell due to reproduction
    else:
        return 0  # The cell remains dead