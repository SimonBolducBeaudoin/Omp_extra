#pragma once

#if defined(__CYGWIN__) || defined(__MINGW64__)
    // see number from: sdkddkver.h
    // https://docs.microsoft.com/fr-fr/windows/desktop/WinProg/using-the-windows-headers
    #define _WIN32_WINNT 0x0602 // Windows 8
	#define WIN32_LEAN_AND_MEAN //Faster compilation (remove some unused API)
	#include <windows.h>
    #include <Processtopologyapi.h>
    #include <processthreadsapi.h>
#endif

#include <omp.h>
#include<thread>
#include <assert.h>

void manage_thread_affinity();

template<class BinType>
void reduce( BinType** arrs, uint64_t bins, uint64_t begin, uint64_t end);

int physical_n_threads();