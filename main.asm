.data
POSITION: .half 152,186		# x e y inicial
MURO: .half 70,24,248,201	# Coordenadas do muro
CONTADOR: .word 0		# Auxilia a printar a sprite adequada, se for ímpar ou par
BLOCOS_BLOQUEADOS: .byte 1, 2, 3, 4, 5, 11, 12, 13, 14, 15, 21, 22
POKEBOLA: .byte 0 
NUM_POKEBOLA: .byte 3, 4	# Adicionar quantidade de pokebolas por fase
PEGOU_POKEBOLA: .byte 0		# Sempre zerar a cada nova fase		
PEGOU_CHAVE: .byte 0 
PRINTOU_CATERPIE: .byte 0 
FASE1: .byte 	
		12, 2, 1, 0, 0, 0, 0, 0, 1, 2, 2,
        	12, 2, 1, 0, 0, 0,20, 0, 1, 2, 2,
        	11, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1,
        	11,21, 1, 0, 0, 0, 0, 0, 0, 0, 1,
        	11, 0, 2, 2, 0, 0, 0, 0, 2, 0, 1,
        	11, 0, 2, 2, 2, 0, 0, 0,20, 2, 1,
        	11, 0, 0, 2, 2, 1, 0, 0, 0, 0, 1,
        	11, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1,
        	11, 0,20, 0, 0, 0, 0, 0, 2, 0, 1,
        	11, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1,
        	12, 2, 2, 1, 0, 0, 0, 1, 2, 2, 2 

FASE2: .byte 
		15, 8, 5, 5, 5, 5,20, 2, 0, 0, 0,
        	15, 8, 9, 9, 9, 9, 0, 0, 0, 2,20,
        	15, 8, 5, 5, 5, 5, 5, 5, 5, 5, 5,
        	10, 0, 0, 0, 0, 0, 0, 0, 0,20, 5,
        	10, 2, 2, 1, 2, 2, 3, 2, 1, 2, 5,
        	10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 5,
        	15, 5, 5, 5, 5, 5, 5, 6, 5, 5, 5,
        	12, 2, 0, 3, 2, 3, 2, 0, 3, 2, 2,
        	20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
        	11, 0, 1, 2, 3, 2, 1, 2, 3, 1, 0,
        	21, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		
.include "tiles.data"
.include "Capa.data"
.include "fase1.data"
.include "fase2.data"
.include "/sprites/pikachu/pikachu_front.data"
.include "/sprites/pikachu/pikachu_front1.data"
.include "/sprites/pikachu/pikachu_right.data"
.include "/sprites/pikachu/pikachu_right1.data"
.include "/sprites/pikachu/pikachu_left.data"
.include "/sprites/pikachu/pikachu_left1.data"
.include "/sprites/pikachu/pikachu_back.data"
.include "/sprites/pikachu/pikachu_back1.data"
.include "/sprites/numeros/ZERO.data"
.include "/sprites/numeros/UM.data"
.include "/sprites/numeros/DOIS.data"
.include "/sprites/numeros/TRES.data"
.include "/sprites/numeros/QUATRO.data"
.include "/sprites/numeros/CINCO.data"
.include "/sprites/BauAberto.data"
.include "/sprites/BauAbertoChave.data"
.include "/sprites/PortaAberta.data"
.include "/sprites/Caterpie.data"

.text
.include "macro.asm"
# Carrega a imagem1
INICIO:
	frame_atual()
	print_background(Capa)		# Printa a capa na frame inicial
	next_frame()
	print_background(fase1)		# Printa a fase 1 na próxima frame

KEYBOARD_1:
	# Descomentar no fim	
	
	#li t1,0xFF200000	# carrega o endereço de controle do KDMMIO
	#lw t0,0(t1)		# Le bit de Controle Teclado
	#andi t0,t0,0x0001	# mascara o bit menos significativo
   	#beq t0,zero,KEYBOARD   # Se não há tecla pressionada então volta pro LOOP
  	#j PROX_LABEL 		# vai para a próxima LABEL se pressionar uma tecla
  	
PROX_LABEL:
	change_frame()
	
##############################################################################################################################	
#															     #
#	   						FASE 1 							             #
#															     #
##############################################################################################################################

	next_frame()
	print_background(fase1)
	
j PRINT_1
.include "print.asm"	
.include "clean.asm"
.include "mapa.asm"	
PRINT_1:
	
	
load_fase(FASE1)
frame_atual()
call PRINT_MAPA			
	
PIKACHU:
	frame_atual()
	load_values(152,186,pikachu_back)
	call PRINT_IMAGE
	frame_atual()
	load_values(268,48,TRES)
	call PRINT_IMAGE
	frame_atual()
	load_values(268,93,ZERO)
	call PRINT_IMAGE

	
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
	verify('2',INT_INICIO_FASE2)
	j KEYBOARD_LOOP
	
	
# Aperta W

MOV_UP:

	load_position(POSITION)
	frame_atual()
	clean_image(fase1)
	
	call CLEAN_IMAGE
	load_position(POSITION)
	
	# Estrutura Condicional que verifica qual a ultima tecla
	# através de um contador que diz se é ímpar ou par
	ultima_tecla(MOV1_UP)
	j MOV2_UP

RESETA_MU:
	la a5, POSITION
	lh s5, 2(a5)
	addi s5, s5, 16
	sh s5, 2(a5)
	j PRINT_MU
	
MOV1_UP:
	frame_atual()
	movement_y_up(pikachu_back)
	verifica_muro(RESETA_MU)
	bloco_atual()
	verifica_bloco(FASE1,RESETA_MU)
	j PRINT_MU
	
MOV2_UP:
	frame_atual()
	movement_y_up(pikachu_back1)
	verifica_muro(RESETA_MU)
	bloco_atual()
	verifica_bloco(FASE1,RESETA_MU)


	
PRINT_MU:
	load_position(POSITION)
	mv s2, t1
	mv s1, t2
	call PRINT_IMAGE
	conta_pokebola(FASE1,0,88,65) 
	pegou_chave(88,65,152,13)
	proxima_fase(152,26,INICIO_FASE2)
	j KEYBOARD_LOOP
	
	#t0 = frame
	#s2 = x
	#s1 = y
	#a1 = label
	
	
# APERTA S

MOV_DOWN:

	load_position(POSITION)
	frame_atual()
	clean_image(fase1)
	
	call CLEAN_IMAGE
	load_position(POSITION)
	
	# Estrutura Condicional que verifica qual a ultima tecla
	
	ultima_tecla(MOV1_DO)
	j MOV2_DO

RESETA_DO:
	la a5, POSITION
	lh s5, 2(a5)
	addi s5, s5, -16
	sh s5, 2(a5)
	j PRINT_DO		
	
MOV1_DO:
	frame_atual()
	movement_y_down(pikachu_front)
	verifica_muro(RESETA_DO)
	bloco_atual()
	verifica_bloco(FASE1,RESETA_DO)
	j PRINT_DO
	
MOV2_DO:
	frame_atual()
	movement_y_down(pikachu_front1)
	verifica_muro(RESETA_DO)
	bloco_atual()
	verifica_bloco(FASE1,RESETA_DO)

	
PRINT_DO:
	load_position(POSITION)
	mv s2, t1
	mv s1, t2
	call PRINT_IMAGE
	conta_pokebola(FASE1,0,88,65)  
	pegou_chave(88,65,152,13)
	proxima_fase(152,26,INICIO_FASE2)
	j KEYBOARD_LOOP
	
	#t0 = frame
	#s2 = x
	#s1 = y
	#a1 = label
	
	
# TRAMPOLIM

INT_INICIO_FASE2: j INICIO_FASE2


# Aperta A

MOV_LEFT:

	load_position(POSITION)
	frame_atual()
	clean_image(fase1)
	
	call CLEAN_IMAGE
	load_position(POSITION)
	
	# Estrutura Condicional que verifica qual a ultima tecla
	
	ultima_tecla(MOV1_LE)
	j MOV2_LE

RESETA_LE:
	la a5, POSITION
	lh s5, 0(a5)
	addi s5, s5, 16
	sh s5, 0(a5)
	j PRINT_LE	
		
MOV1_LE:
	frame_atual()
	movement_x_left(pikachu_left)
	verifica_muro(RESETA_LE)
	bloco_atual()
	verifica_bloco(FASE1,RESETA_LE)
	j PRINT_LE
	
MOV2_LE:
	frame_atual()
	movement_x_left(pikachu_left1)
	verifica_muro(RESETA_LE)
	bloco_atual()
	verifica_bloco(FASE1,RESETA_LE)

	
PRINT_LE:
	load_position(POSITION)
	mv s2, t1
	mv s1, t2
	call PRINT_IMAGE
	conta_pokebola(FASE1,0,88,65) 
	pegou_chave(88,65,152,13) 
	proxima_fase(152,26,INICIO_FASE2)
	j KEYBOARD_LOOP
	
	#t0 = frame
	#s2 = x
	#s1 = y
	#a1 = label
	

# Aperta D
	
MOV_RIGHT:

	load_position(POSITION)
	frame_atual()
	clean_image(fase1)
	
	call CLEAN_IMAGE
	load_position(POSITION)
	
	# Estrutura Condicional que verifica qual a ultima tecla
	
	ultima_tecla(MOV1_RI)
	j MOV2_RI

RESETA_RI:
	la a5, POSITION
	lh s5, 0(a5)
	addi s5, s5, -16
	sh s5, 0(a5)
	j PRINT_RI	
	
MOV1_RI:
	frame_atual()
	movement_x_right(pikachu_right)
	verifica_muro(RESETA_RI)
	bloco_atual()
	verifica_bloco(FASE1,RESETA_RI)
	j PRINT_RI
	
MOV2_RI:
	frame_atual()
	movement_x_right(pikachu_right1)
	verifica_muro(RESETA_RI)
	bloco_atual()
	verifica_bloco(FASE1,RESETA_RI)

	
PRINT_RI:
	load_position(POSITION)
	mv s2, t1
	mv s1, t2
	call PRINT_IMAGE
	conta_pokebola(FASE1,0,88,65)  
	pegou_chave(88,65,152,13)
	proxima_fase(152,26,INICIO_FASE2)
	j KEYBOARD_LOOP
	
	#t0 = frame
	#s2 = x
	#s1 = y
	#a1 = label
	
##############################################################################################################################	
#															     #
#	   						FASE 2 							             #
#															     #
##############################################################################################################################	

INICIO_FASE2:

	change_frame()
	frame_atual()
	print_background(fase2)		# Printa a fase 1 na próxima frame
	frame_atual()
	load_fase(FASE2)
	call PRINT_MAPA
	
RESETA_FASE2:
	la a2, POSITION
	li s4, 152		# Coordenada Inicial X - Posição Pikachu
	sh s4, 0(a2)
	li s4, 185		# Coordenada Inicial Y - Posição Pikachu
	sh s4, 2(a2)
	
	la a2, CONTADOR
	li s4, 0
	sw s4, 0(a2)		# Reseta o Contador
	
	la a2, POKEBOLA
	li s4, 0
	sb s4, 0(a2)		# Reseta as Pokebolas
	
	la a2, PEGOU_POKEBOLA
	li s4, 0
	sb s4, 0(a2)		# Reseta se Pegou as Pokebolas
	
	la a2, PEGOU_CHAVE
	li s4, 0
	sb s4, 0(a2)		# Reseta a chave
	
	
	frame_atual()
	load_values(152,185,pikachu_back)
	call PRINT_IMAGE
	frame_atual()
	load_values(268,48,TRES)
	call PRINT_IMAGE
	frame_atual()
	load_values(268,93,ZERO)
	call PRINT_IMAGE
	
KEYBOARD_LOOP2:

	li t1,0xFF200000
	lw t0,0(t1)
	andi t0,t0,0x0001
  	beq t0,zero,KEYBOARD_LOOP2
  	lw t0,4(t1)			# Tecla pressionada = t0


	verify('w',MOV_UP2)
	verify('s',MOV_DOWN2)
	verify('a',MOV_LEFT2)
	verify('d',MOV_RIGHT2)
	j KEYBOARD_LOOP2
	
	
# Aperta W

MOV_UP2:

	load_position(POSITION)
	frame_atual()
	clean_image(fase2)
	
	call CLEAN_IMAGE
	load_position(POSITION)
	
	# Estrutura Condicional que verifica qual a ultima tecla
	# através de um contador que diz se é ímpar ou par
	ultima_tecla(MOV1_UP2)
	j MOV2_UP2

RESETA_MU2:
	la a5, POSITION
	lh s5, 2(a5)
	addi s5, s5, 16
	sh s5, 2(a5)
	j PRINT_MU2
	
MOV1_UP2:
	frame_atual()
	movement_y_up(pikachu_back)
	verifica_muro(RESETA_MU2)
	bloco_atual()
	verifica_bloco(FASE2,RESETA_MU2)
	j PRINT_MU2
	
MOV2_UP2:
	frame_atual()
	movement_y_up(pikachu_back1)
	verifica_muro(RESETA_MU2)
	bloco_atual()
	verifica_bloco(FASE2,RESETA_MU2)


	
PRINT_MU2:
	load_position(POSITION)
	mv s2, t1
	mv s1, t2
	call PRINT_IMAGE
	conta_pokebola(FASE2,1,72,178) 
	printa_caterpie()
	pegou_chave(72,178,88,13)
	proxima_fase(152,26,INICIO_FASE3)
	j KEYBOARD_LOOP2
	
	#t0 = frame
	#s2 = x
	#s1 = y
	#a1 = label
	
	
# APERTA S

MOV_DOWN2:

	load_position(POSITION)
	frame_atual()
	clean_image(fase2)
	
	call CLEAN_IMAGE
	load_position(POSITION)
	
	# Estrutura Condicional que verifica qual a ultima tecla
	
	ultima_tecla(MOV1_DO2)
	j MOV2_DO2

RESETA_DO2:
	la a5, POSITION
	lh s5, 2(a5)
	addi s5, s5, -16
	sh s5, 2(a5)
	j PRINT_DO2	
	
MOV1_DO2:
	frame_atual()
	movement_y_down(pikachu_front)
	verifica_muro(RESETA_DO2)
	bloco_atual()
	verifica_bloco(FASE2,RESETA_DO2)
	j PRINT_DO2
	
MOV2_DO2:
	frame_atual()
	movement_y_down(pikachu_front1)
	verifica_muro(RESETA_DO2)
	bloco_atual()
	verifica_bloco(FASE2,RESETA_DO2)

	
PRINT_DO2:
	load_position(POSITION)
	mv s2, t1
	mv s1, t2
	call PRINT_IMAGE
	conta_pokebola(FASE2,1,72,178)  
	printa_caterpie()
	pegou_chave(72,178,88,13)
	proxima_fase(152,26,INICIO_FASE3)
	j KEYBOARD_LOOP2
	
	#t0 = frame
	#s2 = x
	#s1 = y
	#a1 = label
	

# Aperta A

MOV_LEFT2:

	load_position(POSITION)
	frame_atual()
	clean_image(fase2)
	
	call CLEAN_IMAGE
	load_position(POSITION)
	
	# Estrutura Condicional que verifica qual a ultima tecla
	
	ultima_tecla(MOV1_LE2)
	j MOV2_LE2

RESETA_LE2:
	la a5, POSITION
	lh s5, 0(a5)
	addi s5, s5, 16
	sh s5, 0(a5)
	j PRINT_LE2
		
MOV1_LE2:
	frame_atual()
	movement_x_left(pikachu_left)
	verifica_muro(RESETA_LE2)
	bloco_atual()
	verifica_bloco(FASE2,RESETA_LE2)
	j PRINT_LE2
	
MOV2_LE2:
	frame_atual()
	movement_x_left(pikachu_left1)
	verifica_muro(RESETA_LE2)
	bloco_atual()
	verifica_bloco(FASE2,RESETA_LE2)

	
PRINT_LE2:
	load_position(POSITION)
	mv s2, t1
	mv s1, t2
	call PRINT_IMAGE
	conta_pokebola(FASE2,1,72,178) 
	printa_caterpie()
	pegou_chave(72,178,88,13) 
	proxima_fase(152,26,INICIO_FASE3)
	j KEYBOARD_LOOP2
	
	#t0 = frame
	#s2 = x
	#s1 = y
	#a1 = label
	

# Aperta D
	
MOV_RIGHT2:

	load_position(POSITION)
	frame_atual()
	clean_image(fase2)
	
	call CLEAN_IMAGE
	load_position(POSITION)
	
	# Estrutura Condicional que verifica qual a ultima tecla
	
	ultima_tecla(MOV1_RI2)
	j MOV2_RI2

RESETA_RI2:
	la a5, POSITION
	lh s5, 0(a5)
	addi s5, s5, -16
	sh s5, 0(a5)
	j PRINT_RI2	
	
MOV1_RI2:
	frame_atual()
	movement_x_right(pikachu_right)
	verifica_muro(RESETA_RI2)
	bloco_atual()
	verifica_bloco(FASE2,RESETA_RI2)
	j PRINT_RI2
	
MOV2_RI2:
	frame_atual()
	movement_x_right(pikachu_right1)
	verifica_muro(RESETA_RI2)
	bloco_atual()
	verifica_bloco(FASE2,RESETA_RI2)

	
PRINT_RI2:
	load_position(POSITION)
	mv s2, t1
	mv s1, t2
	call PRINT_IMAGE
	conta_pokebola(FASE2,1,72,178)  
	printa_caterpie()
	pegou_chave(72,178,88,13)
	proxima_fase(152,26,INICIO_FASE3)
	j KEYBOARD_LOOP2
	
	#t0 = frame
	#s2 = x
	#s1 = y
	#a1 = label

INICIO_FASE3:

# devolve o controle ao sistema operacional
FIM:
	
	li a7,10		# syscall de exit
	ecall
