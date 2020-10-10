#my first python attempt
#hope you guys would support me
#you are always welcome for checking bugs and reporting them



import process_module             #importing process_module.py
import os                         #importing os module for executing shell commands and others
from colorama import Fore,Style   #importing colorama module for colouring text,JUST FOR FUN...CHEERS!!!

os.system('clear')                #clearing terminal screen

os.system("pyfiglet 'GuessWord'")     #you should install pyfiglet package from requirements.txt 
print("\n\t"+Fore.GREEN + 'Coded By @codedtrap')
print("\n\t"+Fore.GREEN + 'Instagram@Codedtrap')
print(Style.RESET_ALL)           #resetting colorama styles and colours
rem_moves=10                    #variable for storing remaining tries

while('_' in process_module.obf_word and rem_moves!=0):
    print("\n",*process_module.obf_word)    #showing obfuscated words list without brackets and so on
    print("\n","You Have",rem_moves,"Guesses Left")
    result=process_module.accept_move(input("\nEnter Your Guess:"))  #calling accept_move from process_module
    rem_moves-=1                                                    
    if result == 'notright':                #processing process_module.accept_move return values (18..30) 
        print("\nOh..You Missed..")
    elif result == 'exceed':
        print("\nYou Are Supposed To Enter A Character,Not A Word...")
        print("\nYou Missed A Move")
    elif result == "empty":
        print("\nYou Missed A Guess")
    elif result == "exnotright":
        print("You Tried The Same False Move...")
    else:
        print("\nYou Missed A Guess...")
    if process_module.tried_chars != []:
        print("\nYou Have Tried [",*process_module.tried_chars,"]")  #printing tried chars without list structure

if '_' in process_module.obf_word and rem_moves==0:
    os.system('clear')
    print("\nGame Over,You Are Out Of Moves...")
    print("\nRestart Game Again..")
    os.system('exit')
else:
    os.system('clear')  #clearing terminal screen
    print("\nCONGRATS!!!You Won The Game...")
    print("\nIf You Liked This Game...Please Gimme A Star And Also Try To Give Feedbacks,That's How We All Improve")
    os.system('exit')            #exiting terminal
