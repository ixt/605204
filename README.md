# 60//5\204

A sequel to 60//5\203, now with automation!

in this repo there is:  
    * an article list   
    * a python scrypt with no none core dependencies  
    * a shell script that goes through the list, grabbing the articles putting the output through the python script  

Using lynx to get the articles is good _most_ of the time this is demonstrated in the included script which is meant for pulling the 1000 articles that are important to have in every wikipedia & convert them into haikus. The wikipedia chosen was the [Simple English](https://simple.wikipedia.org/wiki/) one. Only one article fails right now (2016/09/05) which is [Trimurti](https://simple.wikipedia.org/wiki/Trimurti) due to too little words, but if one does the process outlined in the python script it _should_ actually find a haiku. This is due to the counting algorithm, which can probably be improved greatly (many examples can be found of it counting too little syllables)  

Utilities I use in the example script:  
    * Lynx
    * cat  
    * sed  
    * echo
    * python (imports sys, os, getopt)  
    * ascii2uni && uni2ascii 


