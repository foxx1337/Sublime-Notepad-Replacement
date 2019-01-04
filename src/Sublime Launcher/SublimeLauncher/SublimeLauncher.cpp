// SublimeLauncher.cpp : Defines the entry point for the application.
//

#include "stdafx.h"
#include "SublimeLauncher.h"
#include <shellapi.h>
#include <strsafe.h>

int APIENTRY _tWinMain(HINSTANCE hInstance,
                     HINSTANCE hPrevInstance,
                     LPTSTR    lpCmdLine,
                     int       nCmdShow)
{
    UNREFERENCED_PARAMETER(hInstance);
    UNREFERENCED_PARAMETER(hPrevInstance);

    const size_t length = wcslen(lpCmdLine) + 2;
    LPTSTR arguments = new TCHAR[length];
    arguments[0] = L'\0';

    int argc;
    LPWSTR *wargv = CommandLineToArgvW(GetCommandLineW(), &argc);

    bool argumentsPassed = false;

	wchar_t *sublimeExe = nullptr;

    for (int i = 1; i < argc; i++)
    {
        if (wcscmp(wargv[i], L"-z") == 0)
        {
            // -z specified - skip the next parameter
            i++;
        }
		else if (wcscmp(wargv[i], L"-s") == 0)
		{
			// -s specified - the next parameter is the full path to sublime_text.exe
			i++;
			if (i >= argc)
			{
				break;
			}

			sublimeExe = _wcsdup(wargv[i]);
		}
        else
        {
            if (argumentsPassed == false)
                wcscat_s(arguments, length, L"\"");
            else
                wcscat_s(arguments, length, L" ");

            argumentsPassed = true;
            wcscat_s(arguments, length, wargv[i]);
        }
    }

    if (argumentsPassed == true)
        wcscat_s(arguments, length, L"\"");
    // this is a test
    // and another
    
    if (sublimeExe == nullptr)
	{
		sublimeExe = _wcsdup(wargv[0]);
		const int lengthExe = wcslen(sublimeExe) + 1;
		sublimeExe[wcslen(sublimeExe) - wcslen(L"SublimeLauncher.exe")] = '\0';
		wcscat_s(sublimeExe, lengthExe, L"sublime_text.exe");
	}

    ShellExecute(NULL, NULL, sublimeExe, arguments, NULL, nCmdShow);

    return (int) 0;
}
