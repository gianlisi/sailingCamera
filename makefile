# A Makefile for testing the gimbaledCamera library 
#
# SYNOPSIS:
#
#   make [all]       - compiles everything and run both unit tests and the main program.
#   make TARGET      - compiles the given target.
#   make runmain     - compiles the main program and its dependencies, and runs the built sample test.
#   make rununittest - compiles the unittest program and its dependencies, and runs the built sample test.
#   make doc         - produces the documentation using doxygen (if installed)
#   make clean 	     - removes all files generated by make.
#   make cleandoc    - removes all files generated by Doxygen.

CPP=g++
CXX=g++

GOOGLETEST_LIB = gtest
GOOGLETEST_INCLUDE = /usr/local/include

CPPFLAGS = -c -Wall -I $(GOOGLETEST_INCLUDE) -std=c++11 -stdlib=libc++
CXXFLAGS = -L /usr/local/lib -l $(GOOGLETEST_LIB) -l pthread

all : unittest rununittest main runmain

runmain : main 
	./main < test1.dat

rununittest : unittest
	./unittest

main : main.o gimbaledCamera.o 
	$(CXX) $(CXXFLAGS) -o main main.o gimbaledCamera.o 

unittest : unittest.o gimbaledCamera.o
	$(CXX) $(CXXFLAGS) -o unittest unittest.o gimbaledCamera.o 

unittest.o : unittest.cpp gimbaledCamera.h
	$(CPP) $(CPPFLAGS) unittest.cpp

main.o : main.cpp gimbaledCamera.h
	$(CPP) $(CPPFLAGS) main.cpp

gimbaledCamera.o : gimbaledCamera.cpp
	$(CPP) $(CPPFLAGS) gimbaledCamera.cpp

doc :
	doxygen Doxyfile

clean :
	rm main unittest *.o 

cleandoc:
	rm -rf html