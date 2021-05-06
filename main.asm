.data

POSITION: .half 100,112		# x e y

.include "Capa.data"
.include "/sprites/pikachu_front.data"
.include "/sprites/pikachu_right.data"
.include "/sprites/pikachu_left.data"
.include "/sprites/pikachu_back.data"
.include "fase1.data"
.include "transparente.data"

.text
.include "macro.asm"
# Carrega a imagem1
INICIO:
	print_background(Capa,0)	# Printa a capa na frame 0
	print_background(fase1,1)	# Printa a fase 1 na frame 1

KEYBOARD_1:
	# Descomentar no fim	
	#li t1,0xFF200000	# carrega o endereço de controle do KDMMIO
	#lw t0,0(t1)		# Le bit de Controle Teclado
	#andi t0,t0,0x0001	# mascara o bit menos significativo
   	#beq t0,zero,KEYBOARD   # Se não há tecla pressionada então volta pro LOOP
  	#j PROX_LABEL 		# vai para a próxima LABEL se pressionar uma tecla
  	
PROX_LABEL:
	change_frame(1)
	
j PRINT_1
.include "print.asm"	
	
PRINT_1:
	load_values(100,112,1,pikachu_front)
	jal PRINT_IMAGE
	load_values(116,112,1,pikachu_back)
	jal PRINT_IMAGE
	load_values(132,112,1,pikachu_right)
	jal PRINT_IMAGE
	load_values(148,112,1,pikachu_left)
	jal PRINT_IMAGE

KEYBOARD_LOOP:

	li t1,0xFF200000
	lw t0,0(t1)
	andi t0,t0,0x0001
  	beq t0,zero,KEYBOARD_LOOP
  	lw t0,4(t1)			#Tecla pressionada = t0


	verify('w',MOV_UP)

MOV_UP:
	
	la a0, POSITION
	lh t1, 0(a0)	# t1 = X
	lh t2, 2(a0)	# t2 = Y
	
	addi s1,t2, -16
	sh s1, 2(a0)
	mv s2, t1
	li t0,1
	la a1, pikachu_back
	jal PRINT_IMAGE
	j KEYBOARD_LOOP
	
	#t0 = frame
	#s2 = x
	#s1 = y
	#a1 = label
	


# devolve o controle ao sistema operacional
FIM:
	
	li a7,10		# syscall de exit
	ecall
