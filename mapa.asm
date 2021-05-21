.text
#################################
#				#
# 	a0 = Mapa		#
# 	t0 = Frame		#
#				#
#################################
PRINT_MAPA:
	li s3, 72		# X inicial dentro do muro	
	li s4, 25		# Y inicial dentro do muro
	li a3, 11
	li a4, 0
	li t4, 0			# Contador 1	Para quando chegar em 121		
	
PRINT_MAPA_DENTRO:
	li s10, 0
	li t1, 121
	beq t4, t1, FIM_PM	

	lb t2, 0(a0)		# t2 = 1
	addi t4,t4,1
	
PRINTA_BLOCO:

	li t3, 16
	mul s0, t3,t2		# Bloco correspondente x 16
	addi s0,s0,8		# Pula as primeiras informaÃ§Ãµes
	la a1, tiles	
	lw s11, 0(a1)
	
	add a1,a1,s0		# Para no endereço inicial que quer printar
	li s1,0xFF000000	# endereco inicial da Memoria VGA - Frame 0
	bgtz  t0, FRAME1_PB	# Verifica qual a frame, se for 1, ele soma 0x00100000 ao 0xFF000000
	j START1_PB
FRAME1_PB:
	li s2, 0x00100000
	add s1,s1,s2		# Endereço que vai printar - Frame 1

START1_PB:
	li s9, 0		# Contador 3
	li t5, 0 		# Contador 2
	li t6, 320		# Usar na quebra de linha
	mul s5, t6,s4		# 320*altura
	add s1,s1, s5 		# Endereço Inicial + 320* Altura
	add s1,s1, s3 		# Endereço Inicial + 320*Altura + Largura
PRINTAR_PB:
	li s7, 256		# Área do bloco, onde o contador precisa parar
	beq t5, s7,ULTIMA_PB
	addi s9,s9, 4
	addi t5,t5, 4	
	addi s10,s10, 1 
	lw s8, 0(a1)		# S8 = Endereço inicial dos "tiles"
	sw s8, 0(s1)		# Printa em s1 (BitMap) o pixel correspondente
	addi s1,s1,4		# Soma 4 ao endereço do BitMap
	addi a1,a1,4 		# Soma 4 ao bloco "tiles"
	beq s9, t3,BREAK_PB
	j PRINTAR_PB

BREAK_PB:
	
	add s1,s1,t6		#Endereço + 320 = Pula a linha
	sub s1,s1,t3		#Endereço - 16 = Diminui pelo tamanho dos pixels
	add a1,a1,s11
	sub a1,a1,t3
	li s9,0
	j PRINTAR_PB

ULTIMA_PB:
	addi a0,a0,1
	addi a4,a4,1
	addi s3,s3,16
	beq a4,a3, SOMA_Y_PB
	j CONTINUA_PB
SOMA_Y_PB:
	addi s4,s4,16		# Quando chegar em 11(tamanho do mapa dentro), ele vai para o próximo Y
	li s3,72		# Reseta o X para o inicial
	li a4,0
CONTINUA_PB:		
	addi s0,s0,16		# Vai para o próximo elemento a ser printado
	j PRINT_MAPA_DENTRO
	
FIM_PM:
	ret
	
