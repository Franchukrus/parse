#include <cstring>
#ifdef MATHFUNCSDLL_EXPORTS
#define MATHFUNCSDLL_API __declspec(dllexport) 
#else
#define MATHFUNCSDLL_API __declspec(dllimport) 
#endif



#ifndef PARSE_DLL_H
#define PARSE_DLL_H

MATHFUNCSDLL_API double parser(double X, string mmathematical_expression);
#endif