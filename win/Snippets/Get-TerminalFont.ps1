$defConsoleTest = @'
using System.Runtime.InteropServices;
using System;

namespace Win32test
{
    public static class ConsoleTest
    {
        [DllImport( "kernel32.dll", 
                    CharSet = CharSet.Unicode, SetLastError = true)]
        extern static bool GetCurrentConsoleFontEx(
            IntPtr hConsoleOutput,
            bool bMaximumWindow,
            ref CONSOLE_FONT_INFOEX lpConsoleCurrentFont);

        private enum StdHandle
        {
            OutputHandle = -11  // The standard output device.
        }

        [DllImport("kernel32")]
        private static extern IntPtr GetStdHandle(StdHandle index);

        public static string GetFontCsvHeader(){
            return  "FaceName,FontFamily,FontWeight,FontSize";
        }

        public static string GetFontCsv()
        {
            // Instantiating CONSOLE_FONT_INFOEX and setting cbsize
            CONSOLE_FONT_INFOEX ConsoleFontInfo = new CONSOLE_FONT_INFOEX();
            ConsoleFontInfo.cbSize = (uint)Marshal.SizeOf(ConsoleFontInfo);

            GetCurrentConsoleFontEx( GetStdHandle(StdHandle.OutputHandle),
                                     false, 
                                     ref ConsoleFontInfo);

            return  ConsoleFontInfo.FaceName + 
              "," + ConsoleFontInfo.FontFamily + 
              "," + ConsoleFontInfo.FontWeight + 
              "," + ConsoleFontInfo.dwFontSize.X + 
                    "×" + ConsoleFontInfo.dwFontSize.Y;
        }

        [StructLayout(LayoutKind.Sequential)]
        private struct COORD
        {
            public short X;
            public short Y;

            public COORD(short x, short y)
            {
            X = x;
            Y = y;
            }
        }

        // learn.microsoft.com/en-us/windows/console/console-font-infoex
        [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
        private struct CONSOLE_FONT_INFOEX
        {
            public uint  cbSize;
            public uint  nFont;
            public COORD dwFontSize;
            public int   FontFamily;
            public int   FontWeight;
            [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 32)]
            public string FaceName;
        }
    }
}
'@
Add-Type -TypeDefinition $defConsoleTest


# convert output to a pscustomobject
[Win32test.ConsoleTest]::GetFontCsvHeader(), 
[Win32test.ConsoleTest]::GetFontCsv() |
    ConvertFrom-Csv -Delimiter ','