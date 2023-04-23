# Question 2: String Vowel Reversal

This MIPS procedure takes a string and reverses the vowels in it. It assumes that the first vowel in the string is "a" and the last one is "e", and when it prints the string, the first vowel will be "e" and the last one will be "a". All other vowels will also be reversed in the string accordingly. The program is case sensitive and can handle alphanumeric characters.

**How to Use**
- Load the MIPS code into the MARS simulator.
- Run the MIPS code.
- Enter a string of your choice.
- The program will print the string with the vowels reversed.

**Example Run**

    Input: Hello World!

    Output: Hollo Werld!
	
	

Array for store characters in string.

|  e | o  | o  |
| ------------ | ------------ | ------------ |

Get the last address of array.

|  o | o  | e  |
| ------------ | ------------ | ------------ |

Read array reversed and overwrite the string.

# Question 3: Square-Free Number Checker

This MIPS procedure determines whether a positive integer is a square-free number or not. A square-free number is a positive integer that is a product of distinct prime numbers. The program will also print the distinct prime factors of the input integer if it is a square-free number.

**How to Use**
- Load the MIPS code into the MARS simulator.
- Run the MIPS code.
- Enter an integer of your choice.
- The program will print whether the integer is square-free or not, and if it is, it will also print its distinct prime factors.

**Example Runs**

    Input: 8
    
    Output: 8 is not a square-free number.
    
    Input: 12
    
    Output: 12 is not a square-free number.
    
    Input: 15
    
    Output: 15 is a square-free number and has two distinct prime factors: 3 5


# Question 4: Lucky Number Finder

This MIPS procedure finds the lucky number in an nxm matrix. A lucky number is a number where all elements in the same row are greater than the lucky number, and all elements in the same column are less than the lucky number. The program ensures that the elements in the matrix are unique, and asks the user for the number of rows and columns and the matrix elements.

**How to Use**
- Load the MIPS code into the MARS simulator.
- Run the MIPS code.
- Enter the number of rows and columns for the matrix.
- Enter the elements of the matrix.
- The program will print the lucky number for the matrix if it exists, or an error message if there is no lucky number.

**Example Runs**

    Input: Enter the number of columns: 3
    
    Enter the number of rows : 4
    
    Enter the elements of the matrix: 1 5 3 7 8 1 4 9 9 6 4 12
    
    Output: The matrix should have only unique values.
    
    Input: Enter the number of columns: 3
    
    Enter the number of rows : 4
    
    Enter the elements of the matrix: 1 5 3 7 8 2 4 10 9 6 4 12
	
    Output: The lucky number is 6.
	

![Matrix for Lucky Number](https://i.ibb.co/bL3q1H2/resim-2023-04-23-214942754.png "Matrix for Lucky Number")



# Contributing
If you find a bug or have a suggestion for improvement, please submit an issue or a pull request. We welcome all contributions.


# Acknowledgments
I worked on this project independently and did not receive any direct contributions from other individuals or organizations. However, I would like to express my gratitude to the open-source community for providing resources and tools that were used in the development of this project. I also want to thank my mentors and teachers for their guidance and support throughout my learning journey. Finally, I would like to thank anyone who has taken the time to review and provide feedback on this project.
