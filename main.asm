#########################################
# Introdu��o aos Sistemas Computacionais#
#					#
#	Autores:			#
#					#
#	Ana Lu�sa Padilha		#
#	Bruno Vargas			#
#	Harisson Magalh�es		#
#########################################



#########################################
#					#
#		Controles:		#
#					#
# W - move pra cima			#
# A - move pra esquerda			#
# S - move pra baixo			#
# D - move pra direita			#
# R - restart na fase			#
# 1,2,3 - vai pra fase respectiva(cheat)#
#					#
#########################################


.data
POSITION: .half 152,186		# x e y inicial
BOLA_DE_FOGO: .half 88,185	# x e y da bola de fogo
MURO: .half 70,24,248,201	# Coordenadas do muro
CONTADOR: .word 0		# Auxilia a printar a sprite adequada, se for �mpar ou par
BLOCOS_BLOQUEADOS: .byte 1, 2, 3, 4, 5, 11, 12, 13, 14, 15, 21, 22, 24, 25, 26, 27
POKEBOLA: .byte 0 
NUM_POKEBOLA: .byte 3, 4	# Adicionar quantidade de pokebolas por fase
PEGOU_POKEBOLA: .byte 0		# Sempre zerar a cada nova fase		
PEGOU_CHAVE: .byte 0 
PRINTOU_CATERPIE: .byte 0 
BLOCO_ATUAL: .byte 0 
VIDAS: .byte 3 
CONTADOR1: .word 0
CONTADOR_FIREBALL: .byte 0 

# MUSICAS

NUM_GAMEOVER: .word 14
NOTAS_GAMEOVER: 74,250,72,250,67,2500,72,500,76,500,77,1000,72,3000,76,2000,74,500,76,500,77,500,71,500,79,2000,77,1000
NUM_VITORIA: .word 14
NOTAS_VITORIA: 64,849,65,141,62,707,60,283,62,283,64,566,84,141,79,141,77,141,76,707,60,141,55,141,60,141,62,2000
NUM_CAPA: .word 34
NOTAS_CAPA: 55,207,55,207,59,207,60,414,60,207,59,207,55,207,53,207,53,207,52,1449,60,207,60,207,62,207,64,207,62,414,60,207,59,207,59,414,55,207,59,207,60,621,60,1035,60,207,59,207,55,414,53,207,52,414,52,207,53,207,55,414,55,207,53,414,52,207,55,1449

# MAPAS

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
            	27, 30, 20, 24, 24, 24, 24, 24, 30, 30, 30,
            	31, 30, 30, 24, 30, 30, 30, 24, 24, 28, 24,
            	25, 28, 24, 24, 30, 21, 30, 24, 26, 28, 26,
            	25, 28, 24, 24, 30, 30, 30, 24, 26, 30, 30,
            	27, 28, 26, 26, 26, 28, 24, 24, 26, 30, 20,
            	31, 30, 30, 30, 26, 30, 26, 30, 26, 30, 30,
            	31, 30, 30, 30, 30, 30, 30, 30, 30, 30, 30,
		

.text
.include "macro.asm"

#################################
#				#
#	  Abertura		#
#				#
#################################
ABERTURA:
	frame_atual()
	print_background(tela1)
	li a7, 32
	li a0, 5000
	ecall
	next_frame()
	print_background(tela2)
	change_frame()
	li a7, 32
	li a0, 8000
	ecall


#################################
#				#
#	     CAPA		#
#				#
#################################
CAPA_INICIO:
	next_frame()
	print_background(Capa)		# Printa a capa na frame inicial
	change_frame()
	la s0,NUM_CAPA		
	lw s1,0(s0)		
	la s0,NOTAS_CAPA		
	li t0,0			
	li a2,5			
	li a3,127		

LOOP_CAPA:beq t0,s1, FIM_CAPA	
	lw a0,0(s0)		
	lw a1,4(s0)		
	li a7,31		
	ecall			
	mv a0,a1		
	li a7,32		
	ecall			
	addi s0,s0,8		
	addi t0,t0,1		
	j LOOP_CAPA		
	
FIM_CAPA:
	

KEYBOARD_1:
	
	li t1,0xFF200000	# carrega o endere�o de controle do KDMMIO
	lw t0,0(t1)		# Le bit de Controle Teclado
	andi t0,t0,0x0001	# mascara o bit menos significativo
   	beq t0,zero,KEYBOARD_1   # Se n�o h� tecla pressionada então volta pro LOOP
  	j INICIO_FASE1 		# vai para a pr�xima LABEL se pressionar uma tecla
  	
  	
##############################################################################################################################	
#															     #
#	   						FASE 1 							             #
#															     #
##############################################################################################################################
INICIO_FASE1:
	la a2, POSITION
	li s4, 152		# Coordenada Inicial X - Posi��o Pikachu
	sh s4, 0(a2)
	li s4, 186		# Coordenada Inicial Y - Posi��o Pikachu
	sh s4, 2(a2)
	
	la a2, CONTADOR
	li s4, 0
	sw s4, 0(a2)		# Reseta o Contador
	
	la a2, CONTADOR1
	li s4, 0
	sw s4, 0(a2)		# Reseta o Contador1
	
	
	la a2, POKEBOLA
	li s4, 0
	sb s4, 0(a2)		# Reseta as Pokebolas
	
	la a2, PEGOU_POKEBOLA
	li s4, 0
	sb s4, 0(a2)		# Reseta se Pegou as Pokebolas
	
	la a2, PEGOU_CHAVE
	li s4, 0
	sb s4, 0(a2)		# Reseta a chave
	reseta_pokebola(FASE1)
	next_frame()
	print_background(fase1)		# Printa a fase 1 na pr�xima frame
	
	change_frame()
	


	next_frame()
	print_background(fase1)
	
RESETA_FASE1:
	la a2, POSITION
	li s4, 152		# Coordenada Inicial X - Posi��o Pikachu
	sh s4, 0(a2)
	li s4, 186		# Coordenada Inicial Y - Posi��o Pikachu
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
	verify('r',INICIO_FASE1)
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
	# atrav�s de um contador que diz se � �mpar ou par
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
	pegou_chave(88,65,152,13,PortaAberta)
	proxima_fase(152,26,RESTART_FASE2)
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
	pegou_chave(88,65,152,13,PortaAberta)
	proxima_fase(152,26,RESTART_FASE2)
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
	pegou_chave(88,65,152,13,PortaAberta) 
	proxima_fase(152,26,RESTART_FASE2)
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
	pegou_chave(88,65,152,13,PortaAberta)
	proxima_fase(152,26,RESTART_FASE2)
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
	la a5, VIDAS
	lb s11, 0(a5)
        li t4, 0
        beq s11, t4, GAMEOVER_FASE2
        j RESETA_INICIO_FASE2
GAMEOVER_FASE2:
        j GAMEOVER
RESETA_INICIO_FASE2:
	change_frame()
	next_frame()
	print_background(fase2)
	frame_atual()
	print_background(fase2)		# Printa a fase 1 na pr�xima frame
	frame_atual()
	load_fase(FASE2)
	call PRINT_MAPA
	
RESETA_FASE2:
	la a2, POSITION
	li s4, 152		# Coordenada Inicial X - Posi��o Pikachu
	sh s4, 0(a2)
	li s4, 185		# Coordenada Inicial Y - Posi��o Pikachu
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
	verify ('r',RESTART_FASE2)
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
	# atrav�s de um contador que diz se � �mpar ou par
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
	pegou_chave(72,178,88,13,PortaAberta)
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
	pegou_chave(72,178,88,13,PortaAberta)
	proxima_fase(88,25,INICIO_FASE3)
	j KEYBOARD_LOOP2
	
	#t0 = frame
	#s2 = x
	#s1 = y
	#a1 = label
	

# SEGUNDO TRAMPOLIM

INT_CAPA:
	j CAPA_INICIO

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
	pegou_chave(72,178,88,13,PortaAberta) 
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
	pegou_chave(72,178,88,13,PortaAberta)
	proxima_fase(88,25,INICIO_FASE3)
	j KEYBOARD_LOOP2
	
	#t0 = frame
	#s2 = x
	#s1 = y
	#a1 = label

##############################################################################################################################	
#															     #
#	   						FASE 3			 	    				     #
#											    				     #
##############################################################################################################################	
.include "boladefogo.asm"

INICIO_FASE3:
	la a5, VIDAS
	lb s11, 0(a5)
        li t4, 0
        beq s11, t4, GAMEOVER
        j RESETA_INICIO_FASE3
GAMEOVER:  		# if vidas = 0; vai para o game over	
	j GAMEOVER_FIM
	
RESETA_INICIO_FASE3:
	reseta_pokebola(FASE3)
	change_frame()
	next_frame()
	print_background(fase3)
	frame_atual()
	print_background(fase3)		# Printa a fase 1 na pr�xima frame
	frame_atual()
	load_fase(FASE3)
	call PRINT_MAPA
	
RESETA_FASE3:
	la a2, POSITION
	li s4, 152		# Coordenada Inicial X - Posi��o Pikachu
	sh s4, 0(a2)
	li s4, 25		# Coordenada Inicial Y - Posi��o Pikachu
	sh s4, 2(a2)
	
	la a2, CONTADOR
	li s4, 0
	sw s4, 0(a2)		# Reseta o Contador
	
	la a2, CONTADOR1
	li s4, 0
	sw s4, 0(a2)		# Reseta o Contador1
	
	
	la a2, POKEBOLA
	li s4, 0
	sb s4, 0(a2)		# Reseta as Pokebolas
	
	la a2, PEGOU_POKEBOLA
	li s4, 0
	sb s4, 0(a2)		# Reseta se Pegou as Pokebolas
	
	la a2, PEGOU_CHAVE
	li s4, 0
	sb s4, 0(a2)		# Reseta a chave
	
	la a4, BOLA_DE_FOGO
	li s7, 88
	li s8, 185
	sh s7, 0(a4)                    # Reseta bola de fogo 
	sh s8, 2(a4)
	la t4, CONTADOR_FIREBALL
	li t3, 0 
	sb t3, 0(t4) 
	
	frame_atual()
	load_values(72,185,charmander)
	call PRINT_IMAGE
	frame_atual()
	load_values(152,25,pikachu_front)
	call PRINT_IMAGE
	
PRINTAR_VIDAS_FASE3:
	la a7, VIDAS
	lb s10, 0(a7)
	li a4,0
	li s4,1
	li a6,2
	li s6,3
	li s7,4
	li s8,5 
	beq s10, a4, PRINT_VIDA0_FASE3
	beq s10, s4, PRINT_VIDA1_FASE3
	beq s10, a6, PRINT_VIDA2_FASE3
	beq s10, s6, PRINT_VIDA3_FASE3
	beq s10, s7, PRINT_VIDA4_FASE3
	beq s10, s8, PRINT_VIDA5_FASE3
	
PRINT_VIDA0_FASE3:
	frame_atual()
	load_values(268,48,ZERO)
	call PRINT_IMAGE
	j FIM_VIDAS_FASE3
PRINT_VIDA1_FASE3:
	frame_atual()
	load_values(268,48,UM)
	call PRINT_IMAGE
	j FIM_VIDAS_FASE3
PRINT_VIDA2_FASE3:
	frame_atual()
	load_values(268,48,DOIS)
	call PRINT_IMAGE
	j FIM_VIDAS_FASE3
PRINT_VIDA3_FASE3:
	frame_atual()
	load_values(268,48,TRES)
	call PRINT_IMAGE
	j FIM_VIDAS_FASE3
PRINT_VIDA4_FASE3:
	frame_atual()
	load_values(268,48,QUATRO)
	call PRINT_IMAGE
	j FIM_VIDAS_FASE3
PRINT_VIDA5_FASE3:
	frame_atual()
	load_values(268,48,CINCO)
	call PRINT_IMAGE
	j FIM_VIDAS_FASE3

FIM_VIDAS_FASE3:
					
	frame_atual()
	load_values(268,93,ZERO)
	call PRINT_IMAGE


KEYBOARD_LOOP3:

CHARMANDER:
	la s3, CONTADOR1
	lw a5, 0(s3)
	addi a5, a5, 1
	sw a5, 0(s3)
	li t6, 500
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
	conta_pokebola(FASE3,1,152,114) 
	pegou_chave(152,114,216,12,PortaAberta3)
	proxima_fase(216,25,INICIO_FASE4)
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
	conta_pokebola(FASE3,1,152,114)  
	pegou_chave(152,114,216,12,PortaAberta3)
	proxima_fase(216,25,INICIO_FASE4)
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
	conta_pokebola(FASE3,1,152,114) 
	pegou_chave(152,114,216,12,PortaAberta3) 
	proxima_fase(216,25,INICIO_FASE4)
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
	conta_pokebola(FASE3,1,152,114)  
	pegou_chave(152,114,216,12,PortaAberta3)
	proxima_fase(216,25,INICIO_FASE4)
	j KEYBOARD_LOOP3
	
	#t0 = frame
	#s2 = x
	#s1 = y
	#a1 = label
	
GAMEOVER_FIM:
	la a2, VIDAS
	li s4, 3
	sb s4, 0(a2)		# Reseta as vidas
	
	next_frame()
	print_background(gameover)
	change_frame()
	la s0,NUM_GAMEOVER		# define o endere�o do n�mero de notas
	lw s1,0(s0)		# le o numero de notas
	la s0,NOTAS_GAMEOVER		# define o endere�o das notas
	li t0,0			# zera o contador de notas
	li a2,5			# define o instrumento
	li a3,127		# define o volume

LOOP_GO:beq t0,s1, FIM_GAMEOVER		# contador chegou no final? ent�o  v� para FIM
	lw a0,0(s0)		# le o valor da nota
	lw a1,4(s0)		# le a duracao da nota
	li a7,31		# define a chamada de syscall
	ecall			# toca a nota
	mv a0,a1		# passa a dura��o da nota para a pausa
	li a7,32		# define a chamada de syscal 
	ecall			# realiza uma pausa de a0 ms
	addi s0,s0,8		# incrementa para o endere�o da pr�xima nota
	addi t0,t0,1		# incrementa o contador de notas
	j LOOP_GO			# volta ao loop
	
FIM_GAMEOVER:
j INT_CAPA
INICIO_FASE4:

VITORIA:
	la a2, VIDAS
	li s4, 3
	sb s4, 0(a2)		# Reseta as vidas
	next_frame()
	print_background(vitoria)
	change_frame()
	la s0,NUM_VITORIA		
	lw s1,0(s0)		
	la s0,NOTAS_VITORIA		
	li t0,0			
	li a2,5			
	li a3,127		

LOOP_VITORIA:beq t0,s1, FIM_VITORIA	
	lw a0,0(s0)		
	lw a1,4(s0)		
	li a7,31		
	ecall			
	mv a0,a1		
	li a7,32		
	ecall			
	addi s0,s0,8		
	addi t0,t0,1		
	j LOOP_VITORIA		
	
FIM_VITORIA:
	j INT_CAPA
# devolve o controle ao sistema operacional
FIM:
	
	li a7,10		# syscall de exit
	ecall
.data
.include "tiles.data"
.include "/Telas/Capa.data"
.include "/Telas/fase1.data"
.include "/Telas/fase2.data"
.include "/Telas/fase3.data"
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
.include "/sprites/PortaAberta3.data"
.include "/Telas/gameover.data"
.include "/Telas/vitoria.data"
.include "/Telas/tela1.data"
.include "/Telas/tela2.data"