#!/bin/bash
cd ~/documents/compilerbuilding/bnfc-cpp/
echo -e "\e[34mTesting hello.cc \e[0m"
read -p "press enter"
./TestCPP ../grammar-testfiles/hello.cc
echo -e "\e[34mTesting greet.cc \e[0m"
read -p "press enter"
./TestCPP ../grammar-testfiles/greet.cc
echo -e "\e[34mTesting med.cc \e[0m"
read -p "press enter"
./TestCPP ../grammar-testfiles/med.cc
echo -e "\e[34mTesting grade.cc \e[0m"
read -p "press enter"
./TestCPP ../grammar-testfiles/grade.cc
echo -e "\e[34mTesting palin.cc \e[0m"
read -p "press enter"
./TestCPP ../grammar-testfiles/palin.cc
echo -e "\e[34mTesting grammar.cc \e[0m"
read -p "press enter"
./TestCPP ../grammar-testfiles/grammar.cc
