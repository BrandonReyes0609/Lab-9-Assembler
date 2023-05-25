;Brandon Reyes 22992
;Carlos Valladares 221164
;Organizaión de computadoras y Assembler
;Catedratico: Roger Díaz Fuentes


.386
.model flat, stdcall, c
.stack 4096

.data
mensaje1 BYTE 'Junio 2022 %d -ISR-: %d', 0Ah, 0			;Variable que indica los datos mes junio
mensaje2 BYTE 'Julio 2022 %d -ISR-: %d', 0Ah, 0			;Variable que indica los datos mes Julio
mensaje3 BYTE 'Agosto 2022 %d -ISR-: %d', 0Ah, 0		;Variable que indica los datos mes Septiembre
mensaje4 BYTE 'Septiembre 2022 %d -ISR-: %d', 0Ah, 0	;Variable que indica los datos mes Agosto
mensaje5 BYTE 'Octubre 2022 %d -ISR-: %d', 0Ah, 0		;Variable que indica los datos mes Octubre
mensaje6 BYTE 'Nomviembre 2022 %d -ISR-: %d', 0Ah, 0	;Variable que indica los datos mes Nombienbre
mensaje7 BYTE 'Diciembre 2022 %d -ISR-: %d', 0Ah, 0		;Variable que indica los datos mes Diciembre
mensaje8 BYTE 'Enero 2022 %d -ISR-: %d', 0Ah, 0			;Variable que indica los datos mes Enero
mensaje9 BYTE 'Febrero 2022 %d -ISR-: %d', 0Ah, 0		;Variable que indica los datos mes febrero
mensaje10 BYTE 'Marzo 2022 %d -ISR-: %d', 0Ah, 0		;Variable que indica los datos mes Marzo
mensaje11 BYTE 'Abril 2022 %d -ISR-: %d', 0Ah, 0		;Variable que indica los datos mes Abril
mensaje12 BYTE 'Mayo 2022 %d -ISR-: %d', 0Ah, 0			;Variable que indica los datos mes Mayo
mensaje13 BYTE 'Recomendamos actulizar su regimen tributario a Mediano Contribuyente', 0Ah, 0
mensaje14 BYTE 'Puede permancer en Pequenio Contribuyente', 0Ah, 0

junio22 dword 12000			;Cambie el valor de dinero 32 bits del mes 
julio22 dword 1000			;Cambie el valor de dinero 32 bits del mes 
agosto22 dword 1000			;Cambie el valor de dinero 32 bits del mes 
septiembre22 dword 1000		;Cambie el valor de dinero 32 bits del mes 
octubre22 dword 1000000		;Cambie el valor de dinero 32 bits del mes 
noviembre22 dword 100000	;Cambie el valor de dinero 32 bits del mes 
diciembre22 dword 1000		;Cambie el valor de dinero 32 bits del mes 
enero23 dword 1000			;Cambie el valor de dinero 32 bits del mes 
febrero23 dword 1000		;Cambie el valor de dinero 32 bits del mes 
marzo23 dword 1000			;Cambie el valor de dinero 32 bits del mes 
abril23 dword 1000			;Cambie el valor de dinero 32 bits del mes 
mayo23 dword 1000			;Cambie el valor de dinero 32 bits del mes 
tot01 DW 0					;El total de la operaciones
tot02 DW 0					;El total de la operaciones
tot03 DW 0					;El total de la operaciones
tot04 DW 0					;El total de la operaciones
tot05 DW 0					;El total de la operaciones
tot06 DW 0					;El total de la operaciones
tot07 DW 0					;El total de la operaciones
tot08 DW 0					;El total de la operaciones
tot09 DW 0					;El total de la operaciones
tot10 DW 0					;El total de la operaciones
tot11 DW 0					;El total de la operaciones
tot12 DW 0					;El total de la operaciones

.code
	includelib libucrt.lib
	includelib legacy_stdio_definitions.lib
	includelib libcmt.lib
	includelib libvcruntime.lib

	extrn printf:near
	extrn exit:near

public main
main proc
	mov edx, 0				;Se limpia el el residuo del registo
	mov eax, junio22		;Se mueve el valor del registro junio 2022 para el eax
	mov ebx, 20				; Se mueve el 20 al ebx

	div ebx					;Se el dinero o monto del mes se divide dentro de 20 

	mov tot01, ax			;El rendimiento se almacena en el registro del ax, como ya se ha dividido, 
							;se mueve el valor del ax a nuestro primer total

	push dword ptr [tot01]	;Se hace push del valor total de la stack
	push dword ptr [junio22];Se hace push del valor del mes del stack
	push offset mensaje1	;Se realiza el push del mensaje 01 y por el orden este saldra de ultimo
	call printf				;Se llama el mensaje con los valores para poder imprimirlos
	
	mov ax, 0               ; Se limpia el registro ax para hacer repetir con los mese que se recibio 
							; Se repite los mismo pasos anteriores con los siguientes mese, julio,agosto,septiembre, octubre, diciembre,enerro, frebrero, marzo, abril y mayo.
	mov edx, 0
	mov eax, julio22
	mov ebx, 20

	div ebx

	mov tot02, ax

	push dword ptr [tot02]
	push dword ptr [agosto22] 
	push offset mensaje2
	call printf

	mov ax, 0

	mov edx, 0
	mov eax, agosto22
	mov ebx, 20

	div ebx

	mov tot03, ax

	push dword ptr [tot03]
	push dword ptr [agosto22] 
	push offset mensaje3
	call printf

	mov ax, 0

	mov edx, 0
	mov eax, septiembre22
	mov ebx, 20

	div ebx

	mov tot04, ax

	push dword ptr [tot04]
	push dword ptr [septiembre22] 
	push offset mensaje4
	call printf

	mov ax, 0

	mov edx, 0
	mov eax, octubre22
	mov ebx, 20

	div ebx

	mov tot05, ax

	push dword ptr [tot05]
	push dword ptr [octubre22] 
	push offset mensaje5
	call printf

	mov ax, 0

	mov edx, 0
	mov eax, noviembre22
	mov ebx, 20

	div ebx

	mov tot06, ax

	push dword ptr [tot06]
	push dword ptr [noviembre22] 
	push offset mensaje6
	call printf

	mov ax, 0

	mov edx, 0
	mov eax, diciembre22
	mov ebx, 20

	div ebx

	mov tot07, ax

	push dword ptr [tot07]
	push dword ptr [diciembre22] 
	push offset mensaje7
	call printf

	mov ax, 0

	mov edx, 0
	mov eax, enero23
	mov ebx, 20

	div ebx

	mov tot08, ax

	push dword ptr [tot08]
	push dword ptr [enero23] 
	push offset mensaje8
	call printf

	mov ax, 0

	mov edx, 0
	mov eax, febrero23
	mov ebx, 20

	div ebx

	mov tot09, ax

	push dword ptr [tot09]
	push dword ptr [febrero23] 
	push offset mensaje9
	call printf

	mov ax, 0

	mov edx, 0
	mov eax, marzo23
	mov ebx, 20

	div ebx

	mov tot10, ax

	push dword ptr [tot10]
	push dword ptr [marzo23] 
	push offset mensaje10
	call printf

	mov ax, 0

	mov edx, 0
	mov eax, abril23
	mov ebx, 20

	div ebx

	mov tot11, ax

	push dword ptr [tot11]
	push dword ptr [abril23] 
	push offset mensaje11
	call printf

	mov ax, 0

	mov edx, 0
	mov eax, mayo23
	mov ebx, 20

	div ebx

	mov tot12, ax

	push dword ptr [tot12]
	push dword ptr [mayo23] 
	push offset mensaje12
	call printf

	mov eax, 0		 ; Se borra el registro de eax

	add bx, tot01	 ;  Todos los totales obtenidos se suman en el registro bx
	add bx, tot02
	add bx, tot03
	add bx, tot04
	add bx, tot05
	add bx, tot06
	add bx, tot07
	add bx, tot08
	add bx, tot09
	add bx, tot10
	add bx, tot11
	add bx, tot12

	mov ax, 15000				; Se coloca el registro ax para comparar 
	CMP bx, ax					;Se realiza el comparador de valores 
	JA greater					;Se define los jump con las condiciones
	JBE smaller

	greater:					;Si es mayor sigue el codigo
		push offset mensaje13	; Imprime el codigo  
		call printf; 

		jmp endl				; Finaliza el jump

	smaller:					;Si es mayo sigue el codigo
		push offset mensaje14	; Imprime el siguiente mensaje
		call printf				; Imprime el codigo
	endl:; 
		push 0					; Se limpiar el stack que se utilizo
		call exit				;La salida dle programa

main ENDP
end