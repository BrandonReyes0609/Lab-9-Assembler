;Brandon Reyes 22992
;Carlos Valladares 221164
;Organizaión de computadoras y Assembler
;Catedratico: Roger Díaz Fuentes

.386
.model flat, stdcall, c
.stack 4096
;ExitProcess proto,dwExitCode:dword

.data

    ;Declaramos variables para mensajes
    mInMonFac BYTE "Ingrese los siguientes montos a su respectivo mes: ", 0Ah, 0
    mEspacio BYTE " ", 0Ah, 0
	mMeses BYTE "Mes: %s 2022, NIT: 4623690-7, Facturado: %d.00 IVA: %d.00", 0Ah, 0
	mIngresar BYTE "Mes: %s 2022, Monto a Facturar: ", 0
	IngresoValor BYTE "%d",0
    mResultados BYTE "Los resultados con su respectivo Mes, Monto facturado e IVA:", 0Ah, 0
    mEstado BYTE "Tu estado actual correspondiente a tu IVA es: ", 0
    mPeq BYTE "Puede continuar como pequenio contribuyente",0Ah,0
	mGen BYTE "Debe actualizar su regimen tributario a IVA general",0Ah,0

	;Como va a funcionar el Array
	;(0) ene22, (4) feb22, (8) mar22, (12) abr22, (16) may22, (20) jun22, (24) jul22, (28) ago22, (32) sep22, (36) oct22, (40) nov22, (44) dic22
	arrMsg BYTE "Ene", 0, "Feb", 0, "Mar", 0, "Apr", 0, "May", 0, "Jun", 0, "Jul", 0, "Ago", 0, "Sep", 0, "Oct", 0, "Nov", 0, "Dec", 0
	arrMonto DWORD 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

    ; Contador
	Contador DWORD ?

    ; Variable IVA para guardar el resultado del IVA
    IVA DWORD ?

    ; Suma de todos los montos facturados ingresados por el usuario
    SumaTotal DWORD ?

.code

	;Librerias
	includelib libucrt.lib
    includelib legacy_stdio_definitions.lib
    includelib libcmt.lib
    includelib libvcruntime.lib

    extrn printf:near
    extrn scanf:near
    extrn exit:near

;main
main PROC 
	
    push offset mInMonFac    ;Mensaje principal al usuario
    call printf

	mov edi, offset arrMsg                      ;Puntero al primer elemento del array del Mensaje
	mov esi, offset arrMonto                    ;Puntero al primer elemento del array de montos
	mov contador, 12                            ;Contador para los meses

    ;Label para el ingreso de datos del usuario
	Montos:
		push edi							    ; Guarda el puntero a la cadena de meses
        push offset mIngresar				    ; Imprime el mensaje de ingreso
        call printf

        push esi                                ; Damos la dirección con scanf
        push offset IngresoValor              	; dato = formato
        call scanf

        add edi, 4							    ; Avanza el puntero al siguiente elemento en el array de meses
        add esi, 4							    ; Avanza el puntero al siguiente elemento en el array de montos
		sub contador, 1						    ; Se reduce el contador

		cmp contador, 0
		jne Montos							    ; Sí, entonces repetir proceso desde Montos     

    push offset mEspacio                      	;Salto de linea
    call printf

	mov contador, 12                            ;Contador para los arrays de meses
	mov edi, offset arrMsg                      ;Puntero al primer elemento del array del Mensaje
	mov esi, offset arrMonto                    ;Puntero al primer elemento del array de montos
    
    push offset mResultados                   	;Se imprime un mensaje
    call printf

    ;Servira para la impresion del mensaje con el monto facturado, iva y mes
    Impresion:
        mov eax, [esi]                          ; Valor del array Monto
        cmp eax, 0                              
        je DivCero                              ; Saltar la división si EAX es 0
        xor edx, edx                            ; Limpia EDX    
        mov ebx, 20
        div ebx                                 ; Se calcula IVA
        mov IVA, eax                            
        jmp FinDiv
    DivCero:
        mov IVA, 0
    FinDiv:
        push DWORD ptr IVA                      ; Se empuja el valor del IVA calculado al mMeses
        push DWORD ptr [esi]                    ; Se empuja el valor en especifico del array Monto  
        push edi                                ; Se empuja el mes que este esta contenido en el array de meses
        push offset mMeses                    
        call printf

        add esi, 4                              ;Avanza el puntero al siguiente elemento en el array de montos
        add edi, 4                              ;Avanza el puntero al siguiente elemento en el array de meses
        sub contador, 1                         ;Se reduce el contador

        cmp contador, 0
        jne Impresion

    mov esi, offset arrMonto                    ; Puntero al primer elemento del array de los montos
    mov contador, 12                            ; Restablecer el contador a 12

    ;Sirve para hacer un recorrido donde obtendrá el valor total de todos los montos
    FacturadoTotal:
        mov eax, [esi]                          ; Obtenemos el valor en la dirección de memoria contenida en esi
        add SumaTotal, eax                      ; Le sumamos el valor de la dirección esi a la variable SumaTotal

        add esi, 4                              ; Avanzamos al siguiente monto
        dec contador                            ; Decrementamos el contador

        cmp contador, 0
        jne FacturadoTotal  

    push offset mEspacio                      	;Se hace un salto de linea
    call printf

    push offset mEstado                       	;Se le muestra un mensaje donde aparece su Estado
    call printf


    mov eax, SumaTotal                          ;Se obtiene el resultado de la suma de todos los montos
    mov ebx, 150000                             ;Se guarda 150000 en ebx
    cmp eax, ebx                                ;Se compara eax con ebx
    ja ivaGeneral                               ;Si este cumple que salte al Label ivaGeneral
    jna PequenoContribuyente                    ;Si no cumple que salte al Label PequenoContribuyente
    

    ivaGeneral:
	    push offset mGen
	    call printf
	    jmp salida


    PequenoContribuyente:
	    push offset mPeq
	    call printf
	    jmp salida


    salida:
	    push 0
	    call exit

    RET

	push 0
    call exit           ; salir del programa
	
main ENDP
END