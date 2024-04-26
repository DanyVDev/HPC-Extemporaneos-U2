# Import the Cython library
import cython

# Define functions using Cython

# Decorator to enable division by zero checking
def update(lattice):
    # Determine the length of the lattice excluding boundary cells
    cdef int box_length = len(lattice) - 2
    # Declare variables for loop iteration
    cdef int i, j
    # Create a new lattice to store updated values
    lattice_new = [[0 for _ in range(box_length + 2)] for _ in range(box_length + 2)]
    # Iterate over inner cells of the lattice
    for i in range(1, box_length + 1):
        for j in range(1, box_length + 1):
            # Update the value of the current cell using update_rule function
            lattice_new[i][j] = update_rule(lattice, i, j)
    # Return the updated lattice
    return lattice_new

# Decorator to enable division by zero checking
def update_rule(lattice, int i, int j):
    # Declare variable to store the number of neighboring live cells
    cdef int n_neigh
    # Calculate the number of live neighbors for the current cell
    n_neigh = lattice[i + 1][j] + lattice[i][j + 1] + lattice[i + 1][j + 1] + \
        lattice[i + 1][j - 1] + lattice[i - 1][j] + lattice[i][j - 1] + \
        lattice[i - 1][j + 1] + lattice[i - 1][j - 1]
    # Apply the rules of Conway's Game of Life to determine the next state of the cell
    if (lattice[i][j] == 1) and (n_neigh in [2, 3]):
        return 1  # Cell survives to the next generation
    elif lattice[i][j] == 1:
        return 0  # Cell dies due to overpopulation or underpopulation
    elif (lattice[i][j] == 0) and (n_neigh == 3):
        return 1  # Cell is born due to reproduction
    else:
        return 0  # Cell remains dead

