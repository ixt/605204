#! /usr/bin/python3
import os, sys, getopt

def main(argv):
    inputfile = ''
    outputfile = ''
    try:
        opts, args = getopt.getopt(argv,"hi:o:",["ifile=","ofile="])
    except getopt.GetoptError:
        print('CountSyllables.py -i <inputfile> -o <outputfile>')
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print('CountSyllables.py -i <inputfile> -o <outputfile>')
            sys.exit()
        elif opt in ("-i", "--ifile"):
            inputfile = arg
        elif opt in ("-o", "--ofile"):
            outputfile = arg
    with open(inputfile) as f: 
        words = f.read().split() # get the words
    ofile = open(outputfile, "w")
    ofile.write('')
    for w in range(len(words)):
        ofile.write(str(countSyllables(words[w])) + ' ')
    ofile.close()
    sys.exit()


# somewhat rewritten comment by Terososauros on Stackoverflow
def countSyllables(word):
    vowels = "aeiouy"
    numberOfVowels = 0
    lastCharWasVowel = False
    for character in word:
        foundVowel = False
        for vowel in vowels:
            if vowel == character:
                if not lastCharWasVowel: numberOfVowels+=1
                foundVowel = lastCharWasVowel = True
                break
        if not foundVowel:
            lastCharWasVowel = False
    if len(word) > 2 and word[-2:] == "es":
        numberOfVowels-=1
    elif len(word) > 1 and word[-1:] == "e":
        numberOfVowels-=1
    return numberOfVowels

if __name__ == "__main__":
    main(sys.argv[1:])
