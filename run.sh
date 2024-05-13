set -e

macrofile=./macro; 
directory=./$(echo $1 | cut --delimiter "-" --fields 1)
rawfilename=$directory/$1
gcc -m32 -c $macrofile.c -o $macrofile.o; 
nasm -F dwarf -g -f elf32 -i $directory -o $rawfilename.o $rawfilename.asm; 
gcc -m32 -o $rawfilename $rawfilename.o $macrofile.o;
printf "===== compiled =====\n\n\ninput:\n"
$rawfilename
echo