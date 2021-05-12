.data
.text
#################################
#				#
#	    PRINT		#
#				#
#################################

.macro print_background(%label,%frame)
	li t1,0xFF000000	# endereco inicial da Memoria VGA - Frame 0
	li t2,0xFF012C00	# endereco final - Frame 0
	li t3,0
	li t0,%frame
	bgtz  t0, SOMA_PB
	j INICIO_PB
SOMA_PB:
	li t0, 0x00100000
	add t1,t1,t0		# Endere�o Inicial - Frame 1 - 0xFF100000
	add t2,t2,t0		# Endere�o Final - Frame 1 - 0xFF112C00
INICIO_PB:
	 
	la s1,%label		# endere�o dos dados da tela na memoria
	addi s1,s1,8		# primeiro pixels depois das informa��es de nlin ncol
LOOP1_PB: beq t1,t2,FIM_PB	# Se for o �ltimo endere�o ent�o sai do loop
	lw t3,0(s1)		# le um conjunto de 4 pixels : word
	sw t3,0(t1)		# escreve a word na mem�ria VGA
	addi t1,t1,4		# soma 4 ao endere�o
	addi s1,s1,4
	j LOOP1_PB		# volta a verificar
FIM_PB:

.end_macro

#################################
#				#
# 	Troca de frame		#
#				#
#################################

.macro change_frame(%frame)
	li s0,0xFF200604	# Escolhe o Frame 0 ou 1
	li t2,%frame		# inicio Frame
	sw t2,0(s0)
.end_macro

#################################
#				#
#	Carrega valores		#
#   pra usar no PRINT_IMAGE	#
#				#
#################################

.macro load_values(%x,%y,%frame,%label)
li t0, %frame
li s2, %x
li s1, %y
la a1, %label
.end_macro

#################################
#				#
#	   Verifica		#
#   o caractere da KEYBOARD 	#
#				#
#################################

.macro verify(%char,%label)
li t1, %char
beq t1,t0,%label
.end_macro


#################################
#				#
# 	     CLEAN		#
#				#
#################################


.macro clean_image(%frame,%label)
mv s2, t1
mv s1, t2
la a1, %label
li t0, %frame
.end_macro


#################################
#				#
#	   MOVEMENTS		#
#				#
#################################

# Armazena X em t1, e Y em t2

.macro verifica_muro_up()
la a2, MURO
lh t4, 2(a2)
bgt s1,t4,CONTINUA_VMU
addi s1, s1, 16
sh s1, 2(a0)
CONTINUA_VMU:
.end_macro

.macro verifica_muro_down()
la a2, MURO
lh t4, 6(a2)
blt s1,t4,CONTINUA_VMD
addi s1, s1, -16
sh s1, 2(a0)
CONTINUA_VMD:
.end_macro

.macro verifica_muro_left()
la a2, MURO
lh t4, 0(a2)
bge s2,t4,CONTINUA_VML
addi s2, s2, 16
sh s2, 0(a0)
CONTINUA_VML:
.end_macro

.macro verifica_muro_right()
la a2, MURO
lh t4, 4(a2)
blt s2,t4,CONTINUA_VMR
addi s2, s2, -16
sh s2, 0(a0)
CONTINUA_VMR:
.end_macro

.macro load_position(%label)
la a0, %label
lh t1, 0(a0)
lh t2, 2(a0)
.end_macro

.macro movement_y_up(%frame,%label)
li t0,%frame
addi s1,t2, -16
sh s1, 2(a0)
mv s2, t1
la a1,%label
.end_macro

.macro movement_y_down(%frame,%label)
li t0,%frame
addi s1,t2, 16
sh s1, 2(a0)
mv s2, t1
la a1,%label
.end_macro

.macro movement_x_left(%frame,%label)
addi s2,t1, -16
sh s2, 0(a0)
mv s1, t2
li t0,%frame
la a1, %label
.end_macro

.macro movement_x_right(%frame,%label)
addi s2,t1, 16
sh s2, 0(a0)
mv s1, t2
li t0,%frame
la a1, %label
.end_macro

#################################
#				#
#   Verifica a �ltima tecla, 	#
#    se for igual, printa	#
#   uma sprite diferente,	#
#     usando um contador	#
#      que diferencia		#
#      (�mpar ou par)		#
#				#
#################################

.macro ultima_tecla(%label)
la a2,CONTADOR
lw t3, 0(a2)	# Carrega o contador
addi t3,t3,1	# Contador+=1
sw t3, 0(a2)	# Atualiza o Contador 
li t4, 2
rem t0,t3,t4
beqz t0, %label
.end_macro

#################################
#				#
#	Carrega a label		#
#	e a frame para usar	#
#	no procedimento		#
#	PRINT_MAPA		#
#				#
#################################

.macro load_fase(%label,%frame)
la a0, %label
li t4, %frame
.end_macro
