# DFA-Recognizer

A Deterministic Finite Automata recognizer using Racket:
  * Reads on stdin a DFA followed by followed by several additional lines of input.
  * Each additional line of input is a string of alphabet symbols separated by spaces.  
  * For each string, the program prints true if the string is in the language, and false if it is not. 
  
  
A .dfa file represents a DFA by describing, in order, the alphabet, the states, the initial state, the final states, and the transitions. The format for each is as follows:

 * **Alphabet:** A line containing n, the number of symbols in the alphabet, followed by n lines, each containing an alphabet  symbol. Each alphabet symbol must be a string of printable characters, not including whitespace.
 * **States:** A line containing m, the number of states, followed by m lines, each containing the name of a state. Each state name must be a string of letters and/or digits, but no spaces or other characters.
 * **Initial state:** A line containing the name of the initial state for the DFA. The initial state must be one of the states listed in States above.
 * **Final states:** A line containing q, the number of final states, followed by q lines, each containing the name of a final state. Each final state must be one of the states listed in States above.
 * **Transitions:** A line containing r, the number of (non-error) transitions in the transition function T, followed by r lines, each containing three strings st1, sym, st2 separated by spaces. Each such line indicates a transition from state st1 on symbol sym to state st2; that is, T(st1,sym)=st2. st1 and st2 must be listed in States and sym must be listed in Alphabet, above.
