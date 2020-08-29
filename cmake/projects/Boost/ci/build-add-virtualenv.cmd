set HUNTER_BINARY_DIR=C:\__BIN

:: Install Python package 'requests'
python -m pip install --upgrade pip
pip install requests
pip install gitpython
pip install "virtualenv<20"

:: Install latest Polly toolchains and scripts
C:\msys64\usr\bin\wget.exe https://github.com/cpp-pm/polly/archive/master.zip
7z x master.zip
set POLLY_ROOT=%cd%\polly-master

:: Install dependencies (CMake, Ninja)
python %POLLY_ROOT%\bin\install-ci-dependencies.py

:: Tune locations
set PATH=%cd%\_ci\cmake\bin;%PATH%
set PATH=%cd%\_ci\ninja;%PATH%

:: Remove entry with sh.exe from PATH to fix error with MinGW toolchain
:: (For MinGW make to work correctly sh.exe must NOT be in your path)
:: * http://stackoverflow.com/a/3870338/2288008
set PATH=%PATH:C:\Program Files\Git\bin;=%
set PATH=%PATH:C:\Program Files\Git\usr\bin;=%

:: Save git.exe in HUNTER_GIT_EXECUTABLE for upload
:: * https://docs.hunter.sh/en/latest/reference/user-variables.html#hunter-git-executable
:: Variable will be used in CMake so it's okay to use Unix style '/'
set HUNTER_GIT_EXECUTABLE=C:/Program Files/Git/bin/git.exe

set MINGW_PATH=C:\ProgramData\chocolatey\bin

:: MSYS2 location
set MSYS_PATH=C:\msys64\usr\bin

:: Visual Studio 15 2017: Mimic behavior of older versions
set VS150COMNTOOLS=C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\Common7\Tools

:: Windows / VS 2015 - Add msbuild to PATH
if "%TOOLCHAIN:~0,5%"=="vs-14" set PATH=C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\MSBuild\15.0\Bin;%PATH%

python jenkins.py