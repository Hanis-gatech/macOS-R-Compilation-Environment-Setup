# ------------------------------------------------------------------------------------------------------------------------------------
# This file contains instructions to set up the necessary development environment to compile R packages from source on macOS
# We ran into the GCC Fortran issue when we tried to install Seurat and other libraries needed for sc analysis on the loaner laptop
# ------------------------------------------------------------------------------------------------------------------------------------

# There are 5 main steps:
# 1) Install Xcode Command Line Tools 
# 2) Install Homebrew and Verify
# 3) Install GCC and Essential Libraries
# 4) Configure R to Use Homebrew Compilers
#    4a) Find GCC version
#    4b) Create and edit the Makevars file with the nano text editor
#    4c) Insert the macOS R Configuration for Homebrew Compilers in the text editor
# 5) Restart R

# ------------------------------------------------------------------------------------------------------------------------------------

# In the macOS terminal

# Step 1
xcode-select --install

# Step 2
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew --version

#Step 3

brew install gcc libpng

#Step 4 

ls $(brew --prefix)/bin/gcc-* # finds the version of gcc
mkdir -p ~/.R && nano ~/.R/Makevars #opens a new file for the text editor

# paste the following code in the editor

# Replace '15' with your installed GCC version (basically the output of (ls $(brew --prefix)/bin/gcc-* # finds the version of gcc)
BREW_PREFIX := $(shell brew --prefix)

# Compilers
CC=$(BREW_PREFIX)/bin/gcc-15
CXX=$(BREW_PREFIX)/bin/g++-15
FC=$(BREW_PREFIX)/bin/gfortran
F77=$(BREW_PREFIX)/bin/gfortran

# Flags to find Homebrew libraries and headers
LDFLAGS=-L$(BREW_PREFIX)/lib
CPPFLAGS=-I$(BREW_PREFIX)/include

# Save this file using Ctrl + O (not zero) , Return and Ctrl + X

# Step 5 is to restart R.

# ------------------------------------------------------------------------------------------------------------------------------------
# This worked for me!
# ------------------------------------------------------------------------------------------------------------------------------------
