.data
.text
#################################################
#						#
#		PRINT				#
#						#
#################################################

.macro print_image(%x,%y,%frame,%label)
	li t3, 0
	li t1,0xFF000000	# endereco inicial da Memoria VGA - Frame 0
	li t0,%frame
	bgtz  t0, FRAME1_PI
	j START1_PI
FRAME1_PI:
	li t0, 0x00100000
	add t1,t1,t0		# vai pra Frame 1
START1_PI:	
	li s2, %x		# Largura = 160
	li s1, %y		# Altura = 120
	li t0,0
	li s3,320		# multiplicar depois 
	li a3,320
	mul s3, s3, s1		# 320*(Altura) (Y)	
	la a1,%label 		# endereço dos dados da tela na memoria		
	lw s4, 0(a1)		# Largura da Imagem
	lw s5, 4(a1)		# Altura da Imagem
	mul t2, s4,s5
	add t1, t1, s3		# Endereço Inicial + 320*(Altura) 
	add t1, t1, s2		# Endereço Inicial + 320*(Altura) + (Largura)	
	addi a1,a1,8        	# primeiro pixels depois das informações de nlin ncol
    
SAVE_PI: 
	bge t4,t2,FINAL_PI		
	addi t0,t0,4		
	addi t4,t4,4		
	lw t3,0(a1)         
	sw t3,0(t1)         
	addi t1,t1,4        
	addi a1,a1,4	
	beq t0,s4,BREAK1_PI
	j SAVE_PI   
         
BREAK1_PI:
	add t1,t1,a3		#Endereço + 320 = Pula a linha
	sub t1,t1,t0		#Endereço - 16 = Diminui pelo tamanho dos pixels
	li t0,0
	j SAVE_PI
FINAL_PI:
	li t4, 0
.end_macro

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
