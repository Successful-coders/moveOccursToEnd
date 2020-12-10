#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <conio.h>
#include <iostream>

extern "C" float __stdcall moveOccursToEnd(char* line, char movedChar, int lineLength);

void main() {
	const int LINE_CAPACITY = 255;
	const int LINE_LENGTH = 255;

	FILE* file;
	char* str[LINE_CAPACITY];
	char* fileName = new char[LINE_LENGTH];
	char ch = 0;
	int lineCount = 0;

	str[0] = new char[LINE_LENGTH];

	std::cout << "Input file name: ";
	std::cin >> fileName; //test.txt

	fopen_s(&file, fileName, "r");

	if (file)
	{
		std::cout << "\nFile content:\n";
		for (lineCount; !feof(file); lineCount++)
		{
			str[lineCount] = new char[LINE_LENGTH];
			fgets(str[lineCount], LINE_LENGTH, file);
			if (str[lineCount][strlen(str[lineCount]) - 1] == 10)
			{
				str[lineCount][strlen(str[lineCount]) - 1] = 0;
			}
			std::cout << str[lineCount] << "\n";
		}
		fclose(file);

		std::cout << "Input char to move: ";
		std::cin >> ch;
		std::cout << "Result:\n";

		for (int i = 0; i < lineCount; i++)
		{
			moveOccursToEnd(str[i], ch, strlen(str[i]));

			std::cout << str[i] << "\n";
		}
	}
	else
	{
		std::cout << "File not found\n";
	}

	_getch();
}