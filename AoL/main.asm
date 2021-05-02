.data
.include "Capa.data"
.include "/sprites/pikachu_front.data"
.include "fase1.data"

.text
# Carrega a imagem1
FORA:	li t1,0xFF000000	# endereco inicial da Memoria VGA - Frame 0
	li t2,0xFF012C00	# endereco final 
	la s1,Capa		# endereço dos dados da tela na memoria
	addi s1,s1,8		# primeiro pixels depois das informações de nlin ncol
LOOP1: 	beq t1,t2,KEYBOARD		# Se for o último endereço então sai do loop
	lw t3,0(s1)		# le um conjunto de 4 pixels : word
	sw t3,0(t1)		# escreve a word na memória VGA
	addi t1,t1,4		# soma 4 ao endereço
	addi s1,s1,4
	j LOOP1			# volta a verificar

KEYBOARD:
	li t1,0xFF200000	# carrega o endereço de controle do KDMMIO
	lw t0,0(t1)		# Le bit de Controle Teclado
	andi t0,t0,0x0001	# mascara o bit menos significativo
   	beq t0,zero,KEYBOARD   	# Se não há tecla pressionada então volta pro LOOP
  	j PROX_LABEL  		# vai para a próxima LABEL se pressionar uma tecla
  	
PROX_LABEL:
	li s0,0xFF200604	# Escolhe o Frame 0 ou 1
	li t2,1			# inicio Frame 0
	sw t2,0(s0)
	xori t2,t2,0x001
	
	li t1,0xFF100000	# endereco inicial da Memoria VGA - Frame 1
	li t2,0xFF112C00	# endereco final 
	la s1,fase1		# endereço dos dados da tela na memoria
	addi s1,s1,8		# primeiro pixels depois das informações de nlin ncol
LOOP2: 	beq t1,t2,PRINT_IMAGE		# Se for o último endereço então sai do loop
	lw t3,0(s1)		# le um conjunto de 4 pixels : word
	sw t3,0(t1)		# escreve a word na memória VGA
	addi t1,t1,4		# soma 4 ao endereço
	addi s1,s1,4
	j LOOP2
	
PRINT_IMAGE:    
    	# Endereço Inicial + Altura*320 + Largura = Printa imagem em qualquer lugar
    
	li s2, 160		# Largura = 160
	li s1, 120		# Altura = 120
	li t1,0
	mv t0,t1
	li s4, 16		# 16x16 
	li s3,320		# multiplicar depois 
	li a3,320
	mul s3, s3, s1		# 320*(Altura) (Y)
	li t1,0xFF100000	# endereco inicial da Memoria VGA - Frame 1
	add t1, t1, s3		# Endereço Inicial + 320*(Altura) 
	add t1, t1, s2		# Endereço Inicial + 320*(Altura) + (Largura)
    
	li t2,256		# endereco final
	la s1,pikachu_front 	# endereço dos dados da tela na memoria
	addi s1,s1,8        	# primeiro pixels depois das informações de nlin ncol
    
CICLO: 
	bge t4,t2,FIM		
	addi t0,t0,4		
	addi t4,t4,4		
	lw t3,0(s1)         
	sw t3,0(t1)         
	addi t1,t1,4        
	addi s1,s1,4	
	beq t0,s4,BREAK
	j CICLO   
         
BREAK:
	add t1,t1,a3		#Endereço +320 = Pula a linha
	sub t1,t1,t0		#Endereço - 16 = Diminui pelo tamanho dos pixels
	li t0,0
	j CICLO			

# devolve o controle ao sistema operacional
FIM:	
	li a7,10		# syscall de exit
	ecall
