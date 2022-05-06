NAME = omp_extra
PYLIB_EXT = $(if $(filter $(OS),Windows_NT),.pyd,.so)
TARGET_STATIC = lib$(NAME).a
TARGET_PYLIB = bin/$(NAME)$(PYLIB_EXT)

OMP_EXTRA = ../Omp_extra
LIBS = ../libs

ODIR = obj
LDIR = lib
SDIR = src

NUMERICAL_INT_STATIC_LIB = $(wildcard $(NUMERICAL_INT)/*.a)

EXTERNAL_STATIC_LIB = $(NUMERICAL_INT_STATIC_LIB)
EXTERNAL_INCLUDES = -I$(OMP_EXTRA)/$(SDIR)

SRC  = $(wildcard $(SDIR)/*.cpp)
OBJ  = $(patsubst $(SDIR)/%.cpp,$(ODIR)/%.o,$(SRC))
ASS  = $(patsubst $(SDIR)/%.cpp,$(ODIR)/%.s,$(SRC))
DEPS = $(OBJ:.o=.d)

CXX = $(OS:Windows_NT=x86_64-w64-mingw32-)g++
OPTIMIZATION = -march=native
CPP_STD = -std=c++14
WARNINGS = -Wall
MINGW_COMPATIBLE = $(OS:Windows_NT=-DMS_WIN64 -D_hypot=hypot)
DEPS_FLAG = -MMD -MP

POSITION_INDEP = -fPIC
SHARED = -shared

OMP = -fopenmp -fopenmp-simd
MATH = -lm

ifeq ($(shell hostname),Simon-T14) 
	PY = $(OS:Windows_NT=/c/Anaconda3/envs/python2/)python
else
    PY = $(OS:Windows_NT=/c/Anaconda2/)python
endif


PY_INCL := $(shell $(PY) -m pybind11 --includes)

ifeq ($(shell hostname),Simon-T14) 
	PY_LINKS  = $(OS:Windows_NT=-L /c/Anaconda3/envs/python2/ -lpython27)
else
    PY_LINKS  = $(OS:Windows_NT=-L /c/Anaconda2/ -lpython27)
endif


LINKS = $(MATH) $(PY_LINKS) $(OMP) 
LINKING = $(CXX) $(OPTIMIZATION) $(POSITION_INDEP) $(SHARED)  -o $(TARGET_PYLIB) $(OBJ) $(LINKS) $(EXTERNAL_STATIC_LIB) $(DEPS_FLAG) $(MINGW_COMPATIBLE)
STATIC_LIB = ar cr $(TARGET_STATIC) $(OBJ) 

INCLUDES = $(PY_INCL) $(EXTERNAL_INCLUDES) $(OMP)
COMPILE = $(CXX) $(CPP_STD) $(OPTIMIZATION) $(POSITION_INDEP) $(WARNINGS) -c -o $@ $< $(INCLUDES) $(DEPS_FLAG) $(MINGW_COMPATIBLE)
ASSEMBLY = $(CXX) $(CPP_STD) $(OPTIMIZATION) $(POSITION_INDEP) $(WARNINGS) -S -o $@ $< $(INCLUDES) $(DEPS_FLAG) $(MINGW_COMPATIBLE)

all : $(TARGET_PYLIB) $(TARGET_STATIC) $(OBJ)

compile_objects : $(OBJ)

assembly : $(ASS)

python_debug_library : $(TARGET_PYLIB)

static_library : $(TARGET_STATIC)

$(TARGET_PYLIB): $(OBJ)
	@ echo " "
	@ echo "---------Compile library $(TARGET_PYLIB)---------"
	$(LINKING)

$(TARGET_STATIC) : $(OBJ)
	@ echo " "
	@ echo "---------Compiling static library $(TARGET_STATIC)---------"
	$(STATIC_LIB)

$(ODIR)/%.o : $(SDIR)/%.cpp
	@ echo " "
	@ echo "---------Compile object $@ from $<--------"
	$(COMPILE)
	
$(ODIR)/%.s : $(SDIR)/%.cpp
	@ echo " "
	@ echo "---------Assembly $@ from $<--------"
	$(ASSEMBLY)
	
-include $(DEPS)

clean:
	@rm -f $(TARGET_PYLIB) $(TARGET_STATIC) $(OBJ) $(ASS) $(DEPS)
	 	 
.PHONY: all , clean , python_debug_library , compile_objects , assembly