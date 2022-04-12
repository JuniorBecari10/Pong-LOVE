7z -tzip a game.zip .
rename game.zip game.love
copy /b "C:\Program Files\LOVE\love.exe"+game.love game.exe
xcopy "C:\Program Files\LOVE\*.dll" output\
move game.exe output/game.exe

del game.zip
del game.love
