#!/bin/bash
cd ~/documents/compilerbuilding/llvm-hs
echo -e "\e[34mTesting hello.cc \e[0m"
read -p "press enter"
dist/build/llvm-test/llvm-test ../grammar-testfiles/hello.cc
echo -e "\e[34mTesting greet.cc \e[0m"
read -p "press enter"
dist/build/llvm-test/llvm-test ../grammar-testfiles/greet.cc
echo -e "\e[34mTesting med.cc \e[0m"
read -p "press enter"
dist/build/llvm-test/llvm-test ../grammar-testfiles/med.cc
echo -e "\e[34mTesting grade.cc \e[0m"
read -p "press enter"
dist/build/llvm-test/llvm-test ../grammar-testfiles/grade.cc
echo -e "\e[34mTesting palin.cc \e[0m"
read -p "press enter"
dist/build/llvm-test/llvm-test ../grammar-testfiles/palin.cc
echo -e "\e[34mTesting grammar.cc \e[0m"
read -p "press enter"
dist/build/llvm-test/llvm-test ../grammar-testfiles/grammar.cc
