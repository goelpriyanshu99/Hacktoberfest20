#this script imported as base_module in other scripts.
#you are welcome to check for bugs and report in github

import base_module   #source code can be found in base_module.py

chars=base_module.ENG_CHARS   #importing string containing english characters from base_module
obf_word=[]                   #initializing an empty list for obfuscated_word
obf_word=base_module.playing_list  #importing underscore list from base_module
tried_chars=[]                #list for storing tried guesses
def accept_move(char):      #function for processing guesses
    if len(char) > 1:
        return "exceed"      #returns 'exceed' for words(characters are supposed to input)
    if char is '':
        return None         #returns None for empty inputs
    if char.lower() in chars:
        if char in base_module.lucky_word:
            indices=[index for index,item in enumerate(base_module.lucky_word) if item == char]
            for ind in indices:
                obf_word[ind]=char                             #replaces obfuscated word positions.
            return obf_word                                     #returning replaced obfuscated word
        else:
            if char not in tried_chars:
                tried_chars.append(char)
                return "notright"              #returning "notright" for false guesses
            else:
                return "exnotright"            #returning "exnotright" for exisisting false moves 
    else:
        return "NotAChar"       #if given input is a number or not a character entity returning "NotAChar"


    
# coded by@codedtrap
# instagram@codedtrap
