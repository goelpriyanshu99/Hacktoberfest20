# you can add words for playing guessword game using this python script
# use 'python add_words.py <your supposed word>
# you can add many words as you want
# beware of duplicatons,but it doesn't matter by the way
#you can add ANY words!!!please add words that can be found in a dictionary              


import sys

new_words=[]
for i in sys.argv[1:]:                                  #checking system arguements by iterating
        try:
            print('You Entered',int(i),'Is Not Valid..Moving to next item') #converting arguements to integer for checking if the given arguements are correct
            continue   #skippping current iteration for integer input
        except ValueError:        #catching valuerror for detecting strings
            new_words.append(i)                         #appending non-integer arguements to new_words list   
with open('word_list.txt','a') as updated_word_file:    #opening word_list.txt for updation
    for j in new_words:
        if len(j) > 10:
            continue
        updated_word_file.write(j)                      #writing given arguements to word_list.txt
        updated_word_file.write("\n")               #writing newline
        print(j,"Successfully Added To File...")

print('========SUCCESSFULLY FINISHED============')               
#coded by @codedtrap
#instagram@codedtrap
