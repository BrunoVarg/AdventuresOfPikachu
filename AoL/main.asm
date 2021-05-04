.data
.include "Capa.data"
.include "/sprites/pikachu_front.data"
.include "/sprites/pikachu_right.data"
.include "/sprites/pikachu_back.data"
.include "fase1.data"

.text
.include "macro.asm"
# Carrega a imagem1
FORA:	li t1,0xFF000000	# endereco inicial da Memoria VGA - Frame 0
	li t2,0xFF012C00	# endereco final 
	la s1,Capa		# endere�o dos dados da tela na memoria
	addi s1,s1,8		# primeiro pixels depois das informa��es de nlin ncol
LOOP1: 	beq t1,t2,KEYBOARD		# Se for o �ltimo endere�o ent�o sai do loop
	lw t3,0(s1)		# le um conjunto de 4 pixels : word
	sw t3,0(t1)		# escreve a word na mem�ria VGA
	addi t1,t1,4		# soma 4 ao endere�o
	addi s1,s1,4
	j LOOP1			# volta a verificar

KEYBOARD:
	li t1,0xFF200000	# carrega o endere�o de controle do KDMMIO
	lw t0,0(t1)		# Le bit de Controle Teclado
	andi t0,t0,0x0001	# mascara o bit menos significativo
   	beq t0,zero,KEYBOARD   	# Se n�o h� tecla pressionada ent�o volta pro LOOP
  	j PROX_LABEL  		# vai para a pr�xima LABEL se pressionar uma tecla
  	
PROX_LABEL:
	li s0,0xFF200604	# Escolhe o Frame 0 ou 1
	li t2,1			# inicio Frame 0
	sw t2,0(s0)
	xori t2,t2,0x001
	
	li t1,0xFF100000	# endereco inicial da Memoria VGA - Frame 1
	li t2,0xFF112C00	# endereco final 
	la s1,fase1		# endere�o dos dados da tela na memoria
	addi s1,s1,8		# primeiro pixels depois das informa��es de nlin ncol
LOOP2: 	beq t1,t2,PRINT_IMAGE		# Se for o �ltimo endere�o ent�o sai do loop
	lw t3,0(s1)		# le um conjunto de 4 pixels : word
	sw t3,0(t1)		# escreve a word na mem�ria VGA
	addi t1,t1,4		# soma 4 ao endere�o
	addi s1,s1,4
	j LOOP2
PRINT_IMAGE:	
		
	print_image(160,120,1,pikachu_back)
	print_image(176,146,1,pikachu_front)


# devolve o controle ao sistema operacional
FIM:
	
	li a7,10		# syscall de exit
	ecall
