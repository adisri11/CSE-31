#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Declarations of the two functions you will implement
// Feel free to declare any helper functions or global variables
void printPuzzle(char** arr);
void searchPuzzle(char** arr, char* word);
int bSize;

// Helper function prototypes
int convertToLower(char c);
int isEqual(char a, char b);
int dfs(char** puzzle, char* word, int row, int col, int currIndex, int wordLen, int** path, int** visited);

// Convert character to lowercase without using library functions
int convertToLower(char c) {
    if (c >= 'A' && c <= 'Z') {
        return c + ('a' - 'A');
    }
    return c;
}

// Check if two characters are equal (case insensitive)
int isEqual(char a, char b) {
    return convertToLower(a) == convertToLower(b);
}

// Main function, DO NOT MODIFY
int main(int argc, char **argv) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <puzzle file name>\n", argv[0]);
        return 2;
    }
    
    int i, j;
    FILE *fptr;
    
    // Open file for reading puzzle
    fptr = fopen(argv[1], "r");
    if (fptr == NULL) {
        printf("Cannot Open Puzzle File!\n");
        return 0;
    }
    
    // Read the size of the puzzle block
    fscanf(fptr, "%d\n", &bSize);
    
    // Allocate space for the puzzle block and the word to be searched
    char **block = (char**)malloc(bSize * sizeof(char*));
    char *word = (char*)malloc(20 * sizeof(char));
    
    // Read puzzle block into 2D arrays
    for(i = 0; i < bSize; i++) {
        *(block + i) = (char*)malloc(bSize * sizeof(char));
        for (j = 0; j < bSize - 1; ++j) {
            fscanf(fptr, "%c ", *(block + i) + j);
        }
        fscanf(fptr, "%c \n", *(block + i) + j);
    }
    
    fclose(fptr);
    
    printf("Enter the word to search: ");
    scanf("%s", word);
    
    // Print out original puzzle grid
    printf("\nPrinting puzzle before search:\n");
    printPuzzle(block);
    
    // Call searchPuzzle to the word in the puzzle
    searchPuzzle(block, word);
    
    return 0;
}

void printPuzzle(char** arr) {
    // This function will print out the complete puzzle grid (arr).
    // It must produce the output in the SAME format as the samples
    // in the instructions.
    for (int i = 0; i < bSize; i++) {
        for (int j = 0; j < bSize; j++) {
            printf("%c ", *(*(arr + i) + j));
        }
        printf("\n");
    }
}

// DFS search for the word from current position
int dfs(char** puzzle, char* word, int row, int col, int currIndex, int wordLen, int** path, int** visited) {
    // Base case: if we've found all characters of the word
    if (currIndex == wordLen) {
        return 1;
    }
    
    // Out of bounds or already visited
    if (row < 0 || row >= bSize || col < 0 || col >= bSize || *(*(visited + row) + col)) {
        return 0;
    }
    
    // Current character doesn't match
    if (!isEqual(*(*(puzzle + row) + col), *(word + currIndex))) {
        return 0;
    }
    
    // Mark as visited
    *(*(visited + row) + col) = 1;
    
    // Explore all 8 adjacent directions
    int directions[8][2] = {
        {-1, -1}, {-1, 0}, {-1, 1},  // Diagonal up-left, up, up-right
        {0, -1},            {0, 1},   // Left, right
        {1, -1},  {1, 0},  {1, 1}     // Diagonal down-left, down, down-right
    };
    
    for (int i = 0; i < 8; i++) {
        int newRow = row + directions[i][0];
        int newCol = col + directions[i][1];
        
        if (dfs(puzzle, word, newRow, newCol, currIndex + 1, wordLen, path, visited)) {
            // If successful, mark the current cell in the path
            *(*(path + row) + col) = currIndex + 1;
            return 1;
        }
    }
    
    // Unmark as visited (backtrack)
    *(*(visited + row) + col) = 0;
    return 0;
}

// Check if two paths overlap
int pathsOverlap(int** path1, int** path2) {
    for (int i = 0; i < bSize; i++) {
        for (int j = 0; j < bSize; j++) {
            // If both paths have non-zero values at the same position, they overlap
            if (*(*(path1 + i) + j) > 0 && *(*(path2 + i) + j) > 0) {
                return 1;
            }
        }
    }
    return 0;
}

void searchPuzzle(char** arr, char* word) {
    // This function checks if arr contains the search word. If the
    // word appears in arr, it will print out a message and the path
    // as shown in the sample runs. If not found, it will print a
    // different message as shown in the sample runs.
    
    // Determine word length
    int wordLen = 0;
    while (*(word + wordLen) != '\0') {
        wordLen++;
    }
    
    // Store up to 10 different paths (arbitrary limit)
    int*** foundPaths = (int***)malloc(10 * sizeof(int**));
    int pathCount = 0;
    
    // Search for the word starting from each cell
    for (int i = 0; i < bSize && pathCount < 10; i++) {
        for (int j = 0; j < bSize && pathCount < 10; j++) {
            // Check if the current cell matches the first letter
            if (isEqual(*(*(arr + i) + j), *word)) {
                // Create a path for this search attempt
                int** tempPath = (int**)malloc(bSize * sizeof(int*));
                for (int k = 0; k < bSize; k++) {
                    *(tempPath + k) = (int*)calloc(bSize, sizeof(int));
                }
                
                // Create a visited array for DFS
                int** visited = (int**)malloc(bSize * sizeof(int*));
                for (int k = 0; k < bSize; k++) {
                    *(visited + k) = (int*)calloc(bSize, sizeof(int));
                }
                
                // Search using DFS to ensure adjacency
                if (dfs(arr, word, i, j, 0, wordLen, tempPath, visited)) {
                    // Check if this path overlaps with any existing path
                    int overlaps = 0;
                    for (int p = 0; p < pathCount; p++) {
                        if (pathsOverlap(foundPaths[p], tempPath)) {
                            overlaps = 1;
                            break;
                        }
                    }
                    
                    // If it doesn't overlap, add it to our collection
                    if (!overlaps) {
                        foundPaths[pathCount] = tempPath;
                        pathCount++;
                        // Don't free tempPath here since we're storing it
                        tempPath = NULL;  // Set to NULL to avoid double-free later
                    }
                }
                
                // Free memory if path wasn't stored
                if (tempPath != NULL) {
                    for (int k = 0; k < bSize; k++) {
                        free(*(tempPath + k));
                    }
                    free(tempPath);
                }
                
                // Free visited array
                for (int k = 0; k < bSize; k++) {
                    free(*(visited + k));
                }
                free(visited);
            }
        }
    }
    
    // Print the results
    if (pathCount > 0) {
        // For basic solution, just print the first path found
        printf("Word found!\n");
        printf("Printing the search path:\n");
        for (int r = 0; r < bSize; r++) {
            for (int c = 0; c < bSize; c++) {
                printf("%d\t", *(*(foundPaths[0] + r) + c));
            }
            printf("\n");
        }
        
        // For bonus feature: print additional non-overlapping paths with different first letters
        if (pathCount > 1) {
            for (int p = 1; p < pathCount; p++) {
                // Find the first letter position in each path
                int firstLetterRow1 = -1, firstLetterCol1 = -1;
                int firstLetterRow2 = -1, firstLetterCol2 = -1;
                
                for (int r = 0; r < bSize; r++) {
                    for (int c = 0; c < bSize; c++) {
                        if (*(*(foundPaths[0] + r) + c) == 1) {
                            firstLetterRow1 = r;
                            firstLetterCol1 = c;
                        }
                        if (*(*(foundPaths[p] + r) + c) == 1) {
                            firstLetterRow2 = r;
                            firstLetterCol2 = c;
                        }
                    }
                }
                
                // If first letters are at different positions, print the path
                if (firstLetterRow1 != firstLetterRow2 || firstLetterCol1 != firstLetterCol2) {
                    printf("\nWord found!\n");
                    printf("Printing the search path:\n");
                    for (int r = 0; r < bSize; r++) {
                        for (int c = 0; c < bSize; c++) {
                            printf("%d\t", *(*(foundPaths[p] + r) + c));
                        }
                        printf("\n");
                    }
                }
            }
        }
    } else {
        printf("Word not found!\n");
    }
    
    // Free memory
    for (int p = 0; p < pathCount; p++) {
        for (int i = 0; i < bSize; i++) {
            free(*(foundPaths[p] + i));
        }
        free(foundPaths[p]);
    }
    free(foundPaths);
}