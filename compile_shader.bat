@echo off

set vertexExt="vsr"
set fragmentExt="fsr"
set shaderRoot="shaders/"
set platform="windows"

set originalFile=%~dpnx1

set path=%~dp1
set path=%path:/=\%
set name=%~n1
set ext=%~x1

set compExt=%ext:~0,-1%
set type="wrongType"
set profile="wrongProfile"
if "%ext:~1%" == %vertexExt% (
set type="vertex"
set profile="vs_4_0"
)
if "%ext:~1%" == %fragmentExt% (
set type="fragment"
set profile="ps_4_0"
)

set compiledPath=%path:shaders\raw=shaders\compiled%
set compiledFile=%compiledPath%%name%%compExt%
set varDefFile=%shaderRoot%common/varying.def

echo Type of shader: %type%
echo Profile: %profile%
echo Original: %originalFile%
echo Compiled: %compiledFile%
echo VaryingDef: %varDefFile%

if not exist %compiledPath% (
mkdir %compiledPath%
)

"./external/bgfx/shadercDebug.exe" -f %originalFile% -o %compiledFile% -i %shaderRoot%common/ --platform %platform% --varyingdef %varDefFile% --type %type% --profile %profile%