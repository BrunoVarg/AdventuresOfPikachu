.data
.text
#################################################
#						#
#		PRINT				#
#						#
#################################################

.macro print_background(%label,%frame)
	li t1,0xFF000000	# endereco inicial da Memoria VGA - Frame 0
	li t2,0xFF012C00	# endereco final - Frame 0
	li t3,0
	li t0,%frame
	bgtz  t0, SOMA_PB
	j INICIO_PB
SOMA_PB:
	li t0, 0x00100000
	add t1,t1,t0		# Endereço Inicial - Frame 1 - 0xFF100000
	add t2,t2,t0		# Endereço Final - Frame 1 - 0xFF112C00
INICIO_PB:
	 
	la s1,%label		# endereço dos dados da tela na memoria
	addi s1,s1,8		# primeiro pixels depois das informações de nlin ncol
LOOP1_PB: beq t1,t2,FIM_PB	# Se for o último endereço então sai do loop
	lw t3,0(s1)		# le um conjunto de 4 pixels : word
	sw t3,0(t1)		# escreve a word na memória VGA
	addi t1,t1,4		# soma 4 ao endereço
	addi s1,s1,4
	j LOOP1_PB		# volta a verificar
FIM_PB:

.end_macro

.macro change_frame(%frame)
	li s0,0xFF200604	# Escolhe o Frame 0 ou 1
	li t2,%frame		# inicio Frame
	sw t2,0(s0)
.end_macro

.macro load_values(%x,%y,%frame,%label)
li t0, %frame
li s2, %x
li s1, %y
la a1, %label
.end_macro

# Verifica o caractere da KEYBOARD

.macro verify(%char,%label)
li t1, %char
beq t1,t0,%label
.end_macro
