# Example Makefile to compile Fortran code

.PHONY: clean
.PRECIOUS: %.o



# No text/space after statements below!

# Choose your compiler:
FORT = gfortran


# Optimisation flags (last overrules first):
OPT = -O0
OPT = -O2

# Directories for the source, object, module, libary and executable files:
SRCDIR = .
OBJDIR = .obj
MODDIR = .mod
# LIBDIR = lib
BINDIR = .

# Standard objects:
STDOBJ  = $(OBJDIR)/corout.o



# If you need to link to any libraries - ensure that paths are correct!
# Include paths for modules:
CFLAGS += -I /usr/include/libSUFR -I /usr/include/libTheSky -I /usr/lib/fortran/modules/plplot/
# Link libraries:
LFLAGS += -lSUFR -lTheSky

# If your program needs PGPlot:
LFLAGS += -lpgplot
# LFLAGS += -lpg2plplot

# Link against PlPlot:
# Plplot 5.10:
# PLLFLAGS += -lplplotf95d -lplplotf95cd -lpg2plplot
# Plplot 5.11? 5.9?:
# PLLFLAGS += -lplplotf95 -lplplotf95c -lpg2plplot
# Plplot 5.12:
# PLLFLAGS += -lplplotf95 -lpg2plplot_gfortran
# Plplot 5.13:
# PLLFLAGS += -lplplotfortran


# Compiler flags:
CFLAGS += -ffree-line-length-0 -fwhole-file  # -fwhole-program
# CFLAGS += -fdiagnostics-color=auto

# CFLAGS += -pipe
# CFLAGS+=" -funroll-loops"
# CFLAGS += -Ofast


# Enable warnings (recommended! - and solve them in your code):
CFLAGS += -Wall -Wextra
CFLAGS += -Wcharacter-truncation -Wunderflow
# CFLAGS += -Warray-temporaries
# CFLAGS += -Wconversion
# CFLAGS += -Wimplicit-interface
CFLAGS += -fmax-errors=10

# Use implicit none everywhere:
# CFLAGS += -fimplicit-none

# Turn warnings into errors:
# CFLAGS += -Werror



# To debug code:
# OPT = -O0
# CFLAGS += -g -ggdb

#  Enable run-time checks (slows down code, but finds many issues!  Combine with warnings and debug options):
# OPT = -O0
# CFLAGS += -fcheck=all -fbacktrace


CFLAGS += -std=f2008 -fall-intrinsics -pedantic
# CFLAGS += -ffree-line-length-none

# OpenMP:
# CFLAGS += -fopenmp
# LFLAGS += -fopenmp

# Profile code:
# OPT = -O0
# CFLAGS += -pg --coverage
# LFLAGS += -pg --coverage

CFLAGS += -I$(MODDIR) -J$(MODDIR)





# Targets to build:
all: cosyst cotraf


printversion:
    $(FORT) --version

exit:


# Recipe on how to create an object (.o) file:
# Line 1: ingredients: .f90 file, other object files, modules
# Line 2: action: compile
$(OBJDIR)/%.o: $(SRCDIR)/%.f90 $(OBJDIR) $(MODDIR)
    $(FORT) $(OPT) $(CFLAGS) -c $< -o $@





# Recipes to build programs cosyst and cotraf:
cosyst: $(STDOBJ) $(OBJDIR)/cosyst.o
    $(FORT) $(LFLAGS) -o $(BINDIR)/cosyst $(STDOBJ) $(OBJDIR)/cosyst.o

cotraf: $(STDOBJ) $(OBJDIR)/cotraf.o
    $(FORT) $(LFLAGS) -o $(BINDIR)/cotraf $(STDOBJ) $(OBJDIR)/cotraf.o


# Tidy up (object files and modules):
clean:
    rm -f $(OBJDIR)/*.o $(MODDIR)/*.mod


# Create directories for intemediate products if necessary:
$(OBJDIR):
    mkdir $(OBJDIR)

$(MODDIR):
    mkdir $(MODDIR)

$(BINDIR):
    mkdir $(BINDIR)

$(LIBDIR):
    mkdir $(LIBDIR)
