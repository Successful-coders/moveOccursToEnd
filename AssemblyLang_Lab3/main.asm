.386
.model flat

moveChar macro line, char, length
	xor		ecx, ecx		; чистим счетчик цикла
	mov		cl, length		; помещаем длину строки в счетчик цикла

	mov		edi, line		; записываем указатель на строку в edi
	mov		esi, edi		; копируем значение edi в esi

	shift:					; цикл сдвига символов не равных перемещаемому вправо
		lodsb				; считываем первый символ из esi в al
		cmp		al, char	; сравниваем символ в al с перемещаемым
		je		continue	; если равен, то игнорируем
		stosb				; иначе: записываем al в текущую позицию edi

		continue:
	LOOP shift

	mov		eax, esi		; запоминаем индекс последнего символа
	dec		eax
	sub		esi, edi		; высчитываем общее число от числа несоответствующих
	mov		ecx, esi		; ecx - количество соответствующих символов в строке 
	cmp		ecx, 0			; если заменяемый символ не был найден
	je		exit			; завершаем макрокоманду

	mov		edi, eax		; иначе: помещаем в edi конец строки
	mov		al, char		; помещаем в al сам символ
	xor		ebx, ebx		; сдвиг строки = 0

	put:
		mov		[edi+ebx], al ; вставляем символ
		dec		ebx			  ; уменьшаем сдвиг на 1
	LOOP put

	exit:	; выход
ENDM

.data
	sourceLine		dd	?	; входная строка
	occurChar		db	?	; перемещаемый символ
	lineLength		db	?	; длина строки

.code
	_moveOccursToEnd@12 PROC
		push	ebp

		mov		ebx, [esp+8]		; читаем 1 переменную
		mov		sourceLine, ebx		; сохраняем 1 переменную

		mov		ebx, [esp+12]		; читаем 2 переменную
		mov		occurChar, bl		; сохраняем из byte

		mov		ebx, [esp+16]		; читаем 3 переменную
		mov		lineLength, bl		; сохраняем из byte

		moveChar	sourceLine, occurChar, lineLength		; вызываем макрокоманду

		pop		ebp
		ret
	_moveOccursToEnd@12 ENDP
END