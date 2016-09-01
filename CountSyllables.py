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
    with open(outputfile) as s:
        syllables = s.read().split()
    placeInFile = 0
    currentSyllableValue = 0
    currentTotalWords = 0
    line = ''
    desiredValue = 5
    
    for lines in range(3):
        foundLine = False
        if lines == 0 or lines == 2:
            desiredValue = 5
        else:
            desiredValue = 7
        while not foundLine :
            if placeInFile >= len(words) or placeInFile >= len(syllables):
                print('not enough words')
                sys.exit()
            if int(syllables[placeInFile]) == desiredValue:
                line += words[placeInFile]
                line += '\n'
                currentTotalWords = 0
                foundLine = True

            currentSyllableValue = 0
            if int(syllables[placeInFile]) > desiredValue:
                placeInFile += 1
                currentTotalWords = 0
            else:
                for s in range(currentTotalWords):
                    whichWord = (placeInFile - currentTotalWords) + s
                    currentSyllableValue +=  int(syllables[whichWord])
                if currentSyllableValue == desiredValue:
                    for w in range(currentTotalWords):
                        whichWord = (placeInFile - currentTotalWords) + w
                        line += words[whichWord] + ' '
                    line += '\n'
                    currentTotalWords = 0
                    foundLine = True
                if currentSyllableValue > desiredValue:
                    currentTotalWords -= 1
                if currentSyllableValue < desiredValue:
                    currentTotalWords += 1
                placeInFile += 1
        
    print(line)
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
