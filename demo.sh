#!/bin/bash
cd /home/scat666/documents/compilerbau
echo -e "\e[34mExercise 0.1, demonstrate working toolchain\e[0m"
read -p "press enter"
echo "cd cpp"
cd cpp
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
echo -e "\e[31mls -l\e[0m"
ls -l
echo -e "\e[31mbnfc -m CPP.cf\e[0m"
read -p "press enter"
bnfc -m CPP.cf
echo -e "\e[31mls\e[0m"
ls
echo -e "\e[31mmake\e[0m"
read -p "press enter"
make
echo -e "\e[31m./TestCPP foo.cc\e[0m"
read -p "press enter"
./TestCPP foo.cc
read -p "press enter"
cd ../llvm-hs
echo -e "\e[34mExercise 0.2, demonstrate that you can compile and run the demo\e[0m"
read -p "press enter"
echo -e "\e[31mmake test\e[0m"
make test
