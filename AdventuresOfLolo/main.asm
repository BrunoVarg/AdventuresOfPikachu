.data
POSITION: .half 152,186		# x e y inicial
MURO: .half 70,24,248,201	# Coordenadas do muro
CONTADOR: .word 0		# Auxilia a printar a sprite adequada, se for ímpar ou par
BLOCO_ATUAL: .string "\nBLOCO ATUAL = "
BLOCOS_BLOQUEADOS: .byte 1, 2, 3, 4, 5, 11, 12, 13, 14, 15, 21
POKEBOLA: .byte 0 
NUM_POKEBOLA: .byte 3
FASE1: .byte 	12,2,1,0,0,0,0,0,1,2,2,
        	12,2,1,0,0,0,20,0,1,2,2,
        	11,1,1,0,0,0,0,0,1,1,1,
        	11,21,1,0,0,0,0,0,0,0,1,
        	11,0,2,2,0,0,0,0,2,0,1,
        	11,0,2,2,2,0,0,0,20,2,1,
        	11,0,0,2,2,1,0,0,0,0,1,
        	11,0,1,0,0,0,0,0,1,0,1,
        	11,0,20,0,0,0,0,0,2,0,1,
        	11,1,1,1,0,0,0,1,1,1,1,
        	12,2,2,1,0,0,0,1,2,2,2 

		
.include "tiles.data"
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
.include "/sprites/numeros/ZERO.data"
.include "/sprites/numeros/UM.data"
.include "/sprites/numeros/DOIS.data"
.include "/sprites/numeros/TRES.data"
.include "/sprites/numeros/QUATRO.data"
.include "/sprites/numeros/CINCO.data"
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
.include "mapa.asm"	
PRINT_1:

	# 1 - Percorrer o vetor de memória da FASE 1, verificando qual o número que está lá
	# 2 - Printar na coordenada exata do mapa, o bloco correspondente
	# 3 - Verificar colisão	
	
load_fase(FASE1,1)
call PRINT_MAPA			
	
PIKACHU:
	load_values(152,186,1,pikachu_back)
	call PRINT_IMAGE
	load_values(268,48,1,TRES)
	call PRINT_IMAGE
	load_values(268,93,1,ZERO)
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
	j KEYBOARD_LOOP
	
	
# Aperta W

MOV_UP:

	load_position(POSITION)
	clean_image(1,fase1)
	
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
	movement_y_up(1,pikachu_back)
	verifica_muro(RESETA_MU)
	bloco_atual()
	verifica_bloco(FASE1,RESETA_MU)
	conta_pokebola(FASE1,0)
	j PRINT_MU
	
MOV2_UP:
	movement_y_up(1,pikachu_back1)
	verifica_muro(RESETA_MU)
	bloco_atual()
	verifica_bloco(FASE1,RESETA_MU)
	conta_pokebola(FASE1,0)
	
PRINT_MU:
	load_position(POSITION)
	mv s2, t1
	mv s1, t2
	call PRINT_IMAGE
	j KEYBOARD_LOOP
	
	#t0 = frame
	#s2 = x
	#s1 = y
	#a1 = label
	
	
# APERTA S

MOV_DOWN:

	load_position(POSITION)
	clean_image(1,fase1)
	
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
	movement_y_down(1,pikachu_front)
	verifica_muro(RESETA_DO)
	bloco_atual()
	verifica_bloco(FASE1,RESETA_DO)
	conta_pokebola(FASE1,0)
	j PRINT_DO
	
MOV2_DO:
	movement_y_down(1,pikachu_front1)
	verifica_muro(RESETA_DO)
	bloco_atual()
	verifica_bloco(FASE1,RESETA_DO)
	conta_pokebola(FASE1,0)
	
PRINT_DO:
	load_position(POSITION)
	mv s2, t1
	mv s1, t2
	call PRINT_IMAGE
	j KEYBOARD_LOOP
	
	#t0 = frame
	#s2 = x
	#s1 = y
	#a1 = label
	

# Aperta A

MOV_LEFT:

	load_position(POSITION)
	clean_image(1,fase1)
	
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
	movement_x_left(1,pikachu_left)
	verifica_muro(RESETA_LE)
	bloco_atual()
	verifica_bloco(FASE1,RESETA_LE)
	conta_pokebola(FASE1,0)
	j PRINT_LE
	
MOV2_LE:
	movement_x_left(1,pikachu_left1)
	verifica_muro(RESETA_LE)
	bloco_atual()
	verifica_bloco(FASE1,RESETA_LE)
	conta_pokebola(FASE1,0)
	
PRINT_LE:
	load_position(POSITION)
	mv s2, t1
	mv s1, t2
	call PRINT_IMAGE
	j KEYBOARD_LOOP
	
	#t0 = frame
	#s2 = x
	#s1 = y
	#a1 = label
	

# Aperta D
	
MOV_RIGHT:

	load_position(POSITION)
	clean_image(1,fase1)
	
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
	movement_x_right(1,pikachu_right)
	verifica_muro(RESETA_RI)
	bloco_atual()
	verifica_bloco(FASE1,RESETA_RI)
	conta_pokebola(FASE1,0)
	j PRINT_RI
	
MOV2_RI:
	movement_x_right(1,pikachu_right1)
	verifica_muro(RESETA_RI)
	bloco_atual()
	verifica_bloco(FASE1,RESETA_RI)
	conta_pokebola(FASE1,0)
	
PRINT_RI:
	load_position(POSITION)
	mv s2, t1
	mv s1, t2
	call PRINT_IMAGE
	j KEYBOARD_LOOP
	
	#t0 = frame
	#s2 = x
	#s1 = y
	#a1 = label
	
# devolve o controle ao sistema operacional
FIM:
	
	li a7,10		# syscall de exit
	ecall
