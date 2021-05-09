.data
POSITION: .half 152,186	# x e y inicial

CONTADOR: .word 0	# Auxilia a printar a sprite adequada, se for ímpar ou par

.include "Capa.data"
.include "/sprites/pikachu/pikachu_front.data"
.include "/sprites/pikachu/pikachu_front1.data"
.include "/sprites/pikachu/pikachu_right.data"
.include "/sprites/pikachu/pikachu_right1.data"
.include "/sprites/pikachu/pikachu_left.data"
.include "/sprites/pikachu/pikachu_left1.data"
.include "/sprites/pikachu/pikachu_back.data"
.include "/sprites/pikachu/pikachu_back1.data"
.include "fase1.data"


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
.include "clean.asm"	
PRINT_1:
	load_values(152,186,1,pikachu_back)
	jal PRINT_IMAGE

KEYBOARD_LOOP:

	li t1,0xFF200000
	lw t0,0(t1)
	andi t0,t0,0x0001
  	beq t0,zero,KEYBOARD_LOOP
  	lw t0,4(t1)			# Tecla pressionada = t0


	verify('w',MOV_UP)
	verify('s',MOV_DOWN)
	verify('a',MOV_LEFT)
	verify('d',MOV_RIGHT)
	j KEYBOARD_LOOP
	
	
# Aperta W

MOV_UP:

	load_position(POSITION)
	clean_image(1,fase1)
	
	jal CLEAN_IMAGE
	load_position(POSITION)
	
	# Estrutura Condicional que verifica qual a ultima tecla
	# através de um contador que diz se é ímpar ou par
	ultima_tecla(MOV1_UP)
	j MOV2_UP
	
MOV1_UP:
	movement_y_up(1,pikachu_back)
	j PRINT_MU
MOV2_UP:
	movement_y_up(1,pikachu_back1)
PRINT_MU:
	jal PRINT_IMAGE
	j KEYBOARD_LOOP
	
	#t0 = frame
	#s2 = x
	#s1 = y
	#a1 = label
	
	
# APERTA S

MOV_DOWN:

	load_position(POSITION)
	clean_image(1,fase1)
	
	jal CLEAN_IMAGE
	load_position(POSITION)
	
	# Estrutura Condicional que verifica qual a ultima tecla
	
	ultima_tecla(MOV1_DO)
	j MOV2_DO
	
MOV1_DO:
	movement_y_down(1,pikachu_front)
	j PRINT_DO
MOV2_DO:
	movement_y_down(1,pikachu_front1)
PRINT_DO:
	jal PRINT_IMAGE
	j KEYBOARD_LOOP
	
	#t0 = frame
	#s2 = x
	#s1 = y
	#a1 = label
	

# Aperta A

MOV_LEFT:

	load_position(POSITION)
	clean_image(1,fase1)
	
	jal CLEAN_IMAGE
	load_position(POSITION)
	
	# Estrutura Condicional que verifica qual a ultima tecla
	
	ultima_tecla(MOV1_LE)
	j MOV2_LE
	
MOV1_LE:
	movement_x_left(1,pikachu_left)
	j PRINT_LE
MOV2_LE:
	movement_x_left(1,pikachu_left1)
PRINT_LE:
	jal PRINT_IMAGE
	j KEYBOARD_LOOP
	
	#t0 = frame
	#s2 = x
	#s1 = y
	#a1 = label
	

# Aperta D
	
MOV_RIGHT:

	load_position(POSITION)
	clean_image(1,fase1)
	
	jal CLEAN_IMAGE
	load_position(POSITION)
	
	# Estrutura Condicional que verifica qual a ultima tecla
	
	ultima_tecla(MOV1_RI)
	j MOV2_RI
	
MOV1_RI:
	movement_x_right(1,pikachu_right)
	j PRINT_RI
MOV2_RI:
	movement_x_right(1,pikachu_right1)
PRINT_RI:
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