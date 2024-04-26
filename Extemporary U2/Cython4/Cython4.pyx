# cython: boundscheck=False
# cython: wraparound=False

def update(lattice):
    cdef int box_length = len(lattice) - 2
    cdef int i, j
    lattice_new = [[0 for _ in range(box_length + 2)] for _ in range(box_length + 2)]
    for i in range(1, box_length + 1):
        for j in range(1, box_length + 1):
            lattice_new[i][j] = update_rule(lattice, i, j)
    return lattice_new

cdef int update_rule(lattice, int i, int j):
    cdef int n_neigh
    n_neigh = lattice[i + 1][j] + lattice[i][j + 1] + lattice[i + 1][j + 1] + \
              lattice[i + 1][j - 1] + lattice[i - 1][j] + lattice[i][j - 1] + \
              lattice[i - 1][j + 1] + lattice[i - 1][j - 1]
    if (lattice[i][j] == 1) and (n_neigh in [2, 3]):
        return 1
    elif lattice[i][j] == 1:
        return 0
    elif (lattice[i][j] == 0) and (n_neigh == 3):
        return 1
    else:
        return 0
