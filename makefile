NAME = Omp_extra
TARGET_STATIC = lib$(NAME).a

IDIR = includes
ODIR = obj
LDIR = lib
SDIR = src

SRC  = $(wildcard $(SDIR)/*.cpp)
OBJ  = $(patsubst $(SDIR)/%.cpp,$(ODIR)/%.o,$(SRC))
DEPS = $(OBJ:.o=.d)

CXX = $(OS:Windows_NT=x86_64-w64-mingw32-)g++
OPTIMIZATION = -Ofast -march=native
CPP_STD = -std=c++14
WARNINGS = -Wall
MINGW_COMPATIBLE = $(OS:Windows_NT=-DMS_WIN64 -D_hypot=hypot)
DEPS_FLAG = -MMD -MP

POSITION_INDEP = -fPIC

OMP = -fopenmp -fopenmp-simd

STATIC_LIB = ar cr $(TARGET_STATIC) $(OBJ) 

COMPILE = $(CXX) $(CPP_STD) $(OPTIMIZATION) $(POSITION_INDEP) $(WARNINGS) -c -o $@ $< $(OMP) $(DEPS_FLAG) $(MINGW_COMPATIBLE)

all : $(TARGET_STATIC)

$(TARGET_STATIC) : $(OBJ)
	@ echo " "
	@ echo "---------Compiling static library $@ ---------"
	$(STATIC_LIB)
	
$(ODIR)/%.o : $(SDIR)/%.cpp
	@ echo " "
	@ echo "---------Compile object $@ from $<--------"
	$(COMPILE)

$(OBJ) : makefile

-include $(DEPS)

clean:
	@rm -f $(TARGET_STATIC) $(OBJ) $(DEPS)
	 	 
.PHONY: all , clean