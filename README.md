# FFTW_extra
Adding some features to open_mp and wraping some functionnalities to python.

# Output
    - *.so or *.pyd a python library containing the wrapped code.
    - *.a   a static labrary excluding the python features (only c/c++ code).
    
# Dependencies
    All homebrewed libraries are imported using global imports "#include <library.h> ".
    This means that the library must eather be installed in your environnment's path or that it must be included during compilation and linking. 
    You can edit the "CmakeList.txt" to properly include homebrewed libraries.
    - Homebrewed libraries (available on my github : https://github.com/SimonBolducBeaudoin)
        - AutiGitVersion (CMake) (expected to be in a  neighboring folder)
    - C/C++ dependencies
        - openmp
            - Can be installed using your package manager.
        - pybind11
    Pybind11 can be installed using you're python package manager (conda(anaconda env),pip,pacman,...).
    
# Building and compiling
Edit config.cmake for your machine (If you are compiling in a different envionnment than your python installation) so th  at pybind11 can be detected and used.
```bash
cmake -S . -B ./build  # Building in Linux
```
```bash
cmake -S . -B ./build -DCMAKE_TOOLCHAIN_FILE=../CMakeConfigs/mingw_toolchain.cmake # Building in Windows (Cross compiling on Cygwin with mingw)
```
```bash
cmake --build build/ # Compiles the project
```
```bash
cmake --install build/ # Copies files to their intended directory
```   
```bash
cmake --build build/ --target uninstall # uninstall 
```  
```bash
cmake --build build/ --target clean # removes targets 
```   
```bash
rm -R -f build/ # removes build directory
```   
    