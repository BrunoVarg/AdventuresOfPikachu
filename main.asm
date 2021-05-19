.data
POSITION: .half 152,186		# x e y inicial
BOLA_DE_FOGO: .half 88,185	# x e y da bola de fogo
MURO: .half 70,24,248,201	# Coordenadas do muro
CONTADOR: .word 0		# Auxilia a printar a sprite adequada, se for ímpar ou par
BLOCOS_BLOQUEADOS: .byte 1, 2, 3, 4, 5, 11, 12, 13, 14, 15, 21, 22, 24, 25, 26, 27
POKEBOLA: .byte 0 
NUM_POKEBOLA: .byte 3, 4	# Adicionar quantidade de pokebolas por fase
PEGOU_POKEBOLA: .byte 0		# Sempre zerar a cada nova fase		
PEGOU_CHAVE: .byte 0 
PRINTOU_CATERPIE: .byte 0 
BLOCO_ATUAL: .byte 0 
VIDAS: .byte 3 
CONTADOR1: .word 0
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
        	
FASE3: .byte 
		25, 20, 24, 24, 30, 30, 30, 24, 24, 28, 24,
            	25, 28, 24, 24, 24, 28, 24, 24, 24, 28, 24,
            	31, 30, 30, 30, 30, 30, 30, 26, 30, 30, 30,
            	31, 30, 30, 26, 26, 26, 26, 26, 20, 30, 30,
            	27, 30, 30, 24, 24, 24, 24, 24, 30, 30, 30,
            	31, 30, 30, 24, 30, 30, 30, 24, 24, 28, 24,
            	25, 28, 24, 24, 30, 21, 30, 24, 26, 28, 26,
            	25, 28, 24, 24, 30, 30, 30, 24, 26, 30, 30,
            	27, 28, 26, 26, 26, 28, 24, 24, 26, 30, 20,
            	31, 30, 30, 30, 26, 30, 26, 30, 26, 30, 30,
            	31, 30, 30, 30, 30, 20, 30, 30, 30, 30, 30,
		
.include "tiles.data"
.include "Capa.data"
.include "fase1.data"
.include "fase2.data"
.include "fase3.data"
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
.include "/sprites/pikachu/pikachu_morto.data"
.include "/sprites/charmander.data"
.include "/sprites/bolafogo.data"
.text
.include "macro.asm"
# Carrega a imagem1
INICIO:
	frame_atual()
	print_background(Capa)		# Printa a capa na frame inicial
	

KEYBOARD_1:
	# Descomentar no fim	
	
	#li t1,0xFF200000	# carrega o endereço de controle do KDMMIO
	#lw t0,0(t1)		# Le bit de Controle Teclado
	#andi t0,t0,0x0001	# mascara o bit menos significativo
   	#beq t0,zero,KEYBOARD   # Se não há tecla pressionada então volta pro LOOP
  	#j PROX_LABEL 		# vai para a próxima LABEL se pressionar uma tecla
  	
  	
##############################################################################################################################	
#															     #
#	   						FASE 1 							             #
#															     #
##############################################################################################################################
INICIO_FASE1:
	next_frame()
	print_background(fase1)		# Printa a fase 1 na próxima frame
	
	change_frame()
	


	next_frame()
	print_background(fase1)
	
RESETA_FASE1:
	la a2, POSITION
	li s4, 152		# Coordenada Inicial X - Posição Pikachu
	sh s4, 0(a2)
	li s4, 186		# Coordenada Inicial Y - Posição Pikachu
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
	verify ('3',INT_INICIO_FASE3)
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
INT_INICIO_FASE3: j INICIO_FASE3
INT_INICIO_FASE1: j INICIO_FASE1

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
RESTART_FASE2:
	reseta_pokebola(FASE2)
	
INICIO_FASE2:
	change_frame()
	next_frame()
	print_background(fase2)
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
	
	la a2, PRINTOU_CATERPIE
	li s4, 0
	sb s4, 0(a2)		# Reseta os inimigos
	
	frame_atual()
	load_values(152,185,pikachu_back)
	call PRINT_IMAGE
	
PRINTAR_VIDAS:
	la a7, VIDAS
	lb s10, 0(a7)
	li a4,0
	li s4,1
	li a6,2
	li s6,3
	li s7,4
	li s8,5 
	beq s10, a4, PRINT_VIDA0
	beq s10, s4, PRINT_VIDA1
	beq s10, a6, PRINT_VIDA2
	beq s10, s6, PRINT_VIDA3
	beq s10, s7, PRINT_VIDA4
	beq s10, s8, PRINT_VIDA5
	
PRINT_VIDA0:
	frame_atual()
	load_values(268,48,ZERO)
	call PRINT_IMAGE
	j FIM_VIDAS
PRINT_VIDA1:
	frame_atual()
	load_values(268,48,UM)
	call PRINT_IMAGE
	j FIM_VIDAS
PRINT_VIDA2:
	frame_atual()
	load_values(268,48,DOIS)
	call PRINT_IMAGE
	j FIM_VIDAS
PRINT_VIDA3:
	frame_atual()
	load_values(268,48,TRES)
	call PRINT_IMAGE
	j FIM_VIDAS
PRINT_VIDA4:
	frame_atual()
	load_values(268,48,QUATRO)
	call PRINT_IMAGE
	j FIM_VIDAS
PRINT_VIDA5:
	frame_atual()
	load_values(268,48,CINCO)
	call PRINT_IMAGE
	j FIM_VIDAS

FIM_VIDAS:
				
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
	verify ('r',INICIO_FASE2)
	verify ('1',INT_INICIO_FASE1)
	verify ('3',INT_INICIO_FASE3)
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
	perder_vida(22, RESTART_FASE2)
	pegou_chave(72,178,88,13)
	proxima_fase(88,25,INICIO_FASE3)
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
	perder_vida(22, RESTART_FASE2)
	pegou_chave(72,178,88,13)
	proxima_fase(88,25,INICIO_FASE3)
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
	perder_vida(22, RESTART_FASE2)
	pegou_chave(72,178,88,13) 
	proxima_fase(88,25,INICIO_FASE3)
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
	perder_vida(22, RESTART_FASE2)
	pegou_chave(72,178,88,13)
	proxima_fase(88,25,INICIO_FASE3)
	j KEYBOARD_LOOP2
	
	#t0 = frame
	#s2 = x
	#s1 = y
	#a1 = label

##############################################################################################################################	
#											    #
#	   						FASE 3			 	    #
#											    #
##############################################################################################################################	
.include "boladefogo.asm"

INICIO_FASE3:

	reseta_pokebola(FASE3)
	change_frame()
	frame_atual()
	print_background(fase3)		# Printa a fase 1 na próxima frame
	frame_atual()
	load_fase(FASE3)
	call PRINT_MAPA
	
RESETA_FASE3:
	la a2, POSITION
	li s4, 152		# Coordenada Inicial X - Posição Pikachu
	sh s4, 0(a2)
	li s4, 25		# Coordenada Inicial Y - Posição Pikachu
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
	load_values(72,185,charmander)
	call PRINT_IMAGE
	frame_atual()
	load_values(152,25,pikachu_front)
	call PRINT_IMAGE
	frame_atual()
	load_values(268,48,TRES)
	call PRINT_IMAGE
	frame_atual()
	load_values(268,93,ZERO)
	call PRINT_IMAGE
	


KEYBOARD_LOOP3:

CHARMANDER:
	la s3, CONTADOR1
	lw a5, 0(s3)
	addi a5, a5, 1
	sw a5, 0(s3)
	li t6, 50
	beq a5, t6, FIREBALL
	j KEYBOARD_RECEBE
FIREBALL:
	la t5, fase3
	jal ra, BOLA_DE_FOGO_PRINT
	
FORA_BOLA_DE_FOGO:
	la s3, CONTADOR1
	li s6, 0
	sw s6, 0(s3)
	
	
KEYBOARD_RECEBE:
	li t1,0xFF200000
	lw t0,0(t1)
	andi t0,t0,0x0001
  	beq t0,zero,KEYBOARD_LOOP3
  	lw t0,4(t1)			# Tecla pressionada = t0


	
	verify('w',MOV_UP3)
	verify('s',MOV_DOWN3)
	verify('a',MOV_LEFT3)
	verify('d',MOV_RIGHT3)
	verify ('r',INICIO_FASE3)
	verify ('1',INT_INICIO_FASE1)
	verify ('2',INT_INICIO_FASE2)
	

	j KEYBOARD_LOOP3
	
	
# Aperta W

MOV_UP3:

	load_position(POSITION)
	frame_atual()
	clean_image(fase3)
	
	call CLEAN_IMAGE
	load_position(POSITION)
	
	# Estrutura Condicional que verifica qual a ultima tecla
	# através de um contador que diz se é ímpar ou par
	ultima_tecla(MOV1_UP3)
	j MOV2_UP3

RESETA_MU3:
	la a5, POSITION
	lh s5, 2(a5)
	addi s5, s5, 16
	sh s5, 2(a5)
	j PRINT_MU3
	
MOV1_UP3:
	frame_atual()
	movement_y_up(pikachu_back)
	verifica_muro(RESETA_MU3)
	bloco_atual()
	verifica_bloco(FASE3,RESETA_MU3)
	j PRINT_MU3
	
MOV2_UP3:
	frame_atual()
	movement_y_up(pikachu_back1)
	verifica_muro(RESETA_MU3)
	bloco_atual()
	verifica_bloco(FASE3,RESETA_MU3)


	
PRINT_MU3:
	load_position(POSITION)
	mv s2, t1
	mv s1, t2
	call PRINT_IMAGE
	conta_pokebola(FASE3,1,72,178) 
	pegou_chave(72,178,88,13)
	proxima_fase(152,26,INICIO_FASE4)
	j KEYBOARD_LOOP3
	
	#t0 = frame
	#s2 = x
	#s1 = y
	#a1 = label
	
	
# APERTA S

MOV_DOWN3:

	load_position(POSITION)
	frame_atual()
	clean_image(fase3)
	
	call CLEAN_IMAGE
	load_position(POSITION)
	
	# Estrutura Condicional que verifica qual a ultima tecla
	
	ultima_tecla(MOV1_DO3)
	j MOV2_DO3

RESETA_DO3:
	la a5, POSITION
	lh s5, 2(a5)
	addi s5, s5, -16
	sh s5, 2(a5)
	j PRINT_DO3	
	
MOV1_DO3:
	frame_atual()
	movement_y_down(pikachu_front)
	verifica_muro(RESETA_DO3)
	bloco_atual()
	verifica_bloco(FASE3,RESETA_DO3)
	j PRINT_DO3
	
MOV2_DO3:
	frame_atual()
	movement_y_down(pikachu_front1)
	verifica_muro(RESETA_DO3)
	bloco_atual()
	verifica_bloco(FASE3,RESETA_DO3)

	
PRINT_DO3:
	load_position(POSITION)
	mv s2, t1
	mv s1, t2
	call PRINT_IMAGE
	conta_pokebola(FASE3,1,72,178)  
	pegou_chave(72,178,88,13)
	proxima_fase(152,26,INICIO_FASE4)
	j KEYBOARD_LOOP3
	
	#t0 = frame
	#s2 = x
	#s1 = y
	#a1 = label
	

# Aperta A

MOV_LEFT3:

	load_position(POSITION)
	frame_atual()
	clean_image(fase3)
	
	call CLEAN_IMAGE
	load_position(POSITION)
	
	# Estrutura Condicional que verifica qual a ultima tecla
	
	ultima_tecla(MOV1_LE3)
	j MOV2_LE3

RESETA_LE3:
	la a5, POSITION
	lh s5, 0(a5)
	addi s5, s5, 16
	sh s5, 0(a5)
	j PRINT_LE3
		
MOV1_LE3:
	frame_atual()
	movement_x_left(pikachu_left)
	verifica_muro(RESETA_LE3)
	bloco_atual()
	verifica_bloco(FASE3,RESETA_LE3)
	j PRINT_LE3
	
MOV2_LE3:
	frame_atual()
	movement_x_left(pikachu_left1)
	verifica_muro(RESETA_LE3)
	bloco_atual()
	verifica_bloco(FASE3,RESETA_LE3)

	
PRINT_LE3:
	load_position(POSITION)
	mv s2, t1
	mv s1, t2
	call PRINT_IMAGE
	conta_pokebola(FASE3,1,72,178) 
	pegou_chave(72,178,88,13) 
	proxima_fase(152,26,INICIO_FASE4)
	j KEYBOARD_LOOP3
	
	#t0 = frame
	#s2 = x
	#s1 = y
	#a1 = label
	

# Aperta D
	
MOV_RIGHT3:


	load_position(POSITION)
	frame_atual()
	clean_image(fase3)
	
	call CLEAN_IMAGE
	load_position(POSITION)
	
	# Estrutura Condicional que verifica qual a ultima tecla
	
	ultima_tecla(MOV1_RI3)
	j MOV2_RI3

RESETA_RI3:
	la a5, POSITION
	lh s5, 0(a5)
	addi s5, s5, -16
	sh s5, 0(a5)
	j PRINT_RI3	
	
MOV1_RI3:
	frame_atual()
	movement_x_right(pikachu_right)
	verifica_muro(RESETA_RI3)
	bloco_atual()
	verifica_bloco(FASE3,RESETA_RI3)
	j PRINT_RI3
	
MOV2_RI3:
	frame_atual()
	movement_x_right(pikachu_right1)
	verifica_muro(RESETA_RI3)
	bloco_atual()
	verifica_bloco(FASE3,RESETA_RI3)

	
PRINT_RI3:
	load_position(POSITION)
	mv s2, t1
	mv s1, t2
	call PRINT_IMAGE
	conta_pokebola(FASE3,1,72,178)  
	pegou_chave(72,178,88,13)
	proxima_fase(152,26,INICIO_FASE4)
	j KEYBOARD_LOOP3
	
	#t0 = frame
	#s2 = x
	#s1 = y
	#a1 = label

INICIO_FASE4:

# devolve o controle ao sistema operacional
FIM:
	
	li a7,10		# syscall de exit
	ecall
