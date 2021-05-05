.data
.include "Capa.data"
.include "/sprites/pikachu_front.data"
.include "/sprites/pikachu_right.data"
.include "/sprites/pikachu_left.data"
.include "/sprites/pikachu_back.data"
.include "fase1.data"

.text
.include "macro.asm"
# Carrega a imagem1
INICIO:
	print_background(Capa,0)	# Printa a capa na frame 0
	print_background(fase1,1)	# Printa a fase 1 na frame 1

KEYBOARD:
	li t1,0xFF200000	# carrega o endereço de controle do KDMMIO
	lw t0,0(t1)		# Le bit de Controle Teclado
	andi t0,t0,0x0001	# mascara o bit menos significativo
   	beq t0,zero,KEYBOARD   	# Se não há tecla pressionada então volta pro LOOP
  	j PROX_LABEL 		# vai para a próxima LABEL se pressionar uma tecla
  	
PROX_LABEL:
	change_frame(1)
	
PRINT_IMAGE:	
		
	print_image(100,112,1,pikachu_back)
	print_image(116,112,1,pikachu_front)
	print_image(132,112,1,pikachu_right)
	print_image(148,112,1,pikachu_left)
	


# devolve o controle ao sistema operacional
FIM:
	
	li a7,10		# syscall de exit
	ecall
