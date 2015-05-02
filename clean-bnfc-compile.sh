#!/bin/bash
#cd ~/documents/compilerbuilding/bnfc-cpp/
echo -e "\e[31mcleaning the folder\e[0m"
read -p "press enter"
rm -f *.hs
rm -f *.hi
rm -f *.o
rm -f TestCPP
rm -f DocCPP.txt
rm -f Lex*
rm -f Par*
rm -f Makefile
