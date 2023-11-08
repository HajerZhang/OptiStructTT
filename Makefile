# compiler options and file path definition
FC = D:/MinGW/bin/gfortran.exe
FFLAGS = -Wall -pedantic -O3 -J $(MODDIR)
LINKFLAGS = $(THIRDLIB)
SRCDIR = ./src
LIBDIR = ./build/lib
INCDIR = ./include
MODDIR = ./module
BINDIR = ./build

# target executable file
TARGET = $(BINDIR)/StrucOpti

ifeq ($(intel),yes)
	FC = ifort
	FFLAGS = -O3
endif

ifeq ($(debug),yes)
	FFLAGS = -g -fcheck=all -I $(MODDIR) -J $(MODDIR)
endif

ifeq ($(static),yes)
	LINKFLAGS += -static
endif


# source files
SRCS = $(wildcard $(SRCDIR)/*.f90)
OBJS = $(SRCS:$(SRCDIR)/%.f90=$(LIBDIR)/%.o)
MODSRCS = $(wildcard $(INCDIR)/*.f90)
MODOBJS = $(MODSRCS:$(INCDIR)/%.f90=$(LIBDIR)/%.o)


$(TARGET): $(MODOBJS) $(OBJS)
#	@echo TARGET:$@
#	@echo OBJECTS:$^
	$(FC) -o $@ $^ $(LINKFLAGS) $(FFLAGS)

#compile module files and generate *.mod
$(LIBDIR)/%.o: $(INCDIR)/%.f90
	$(FC) $(FFLAGS) -c $< -o $@

#compile source files to object files
$(LIBDIR)/%.o: $(SRCDIR)/%.f90
	$(FC) $(FFLAGS) -c $< -o $@

clean:
	rm $(OBJS) $(MODOBJS) $(TARGET) $(MODDIR)/* *.mod
clean_data:
	rm RunAbaqus.bat task.*
cp:
	cp ./build/StrucOpti.exe ./StrucOpti.exe
