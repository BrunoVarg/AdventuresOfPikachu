.data
.text
.macro print_image(%x,%y,%frame,%label)
	li t1,0xFF000000	# endereco inicial da Memoria VGA - Frame 0
	li t0,%frame
	bgtz  t0, SOMA
	j START1
SOMA:
	li t0, 0x00100000
	add t1,t1,t0		# vai pra Frame 1
START1:	
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
    
SAVE: 
	bge t4,t2,FINAL		
	addi t0,t0,4		
	addi t4,t4,4		
	lw t3,0(a1)         
	sw t3,0(t1)         
	addi t1,t1,4        
	addi a1,a1,4	
	beq t0,s4,BREAK1
	j SAVE   
         
BREAK1:
	add t1,t1,a3		#Endereço +320 = Pula a linha
	sub t1,t1,t0		#Endereço - 16 = Diminui pelo tamanho dos pixels
	li t0,0
	j SAVE
FINAL:
	li t4, 0
.end_macro

.macro troca_frame(%frame)
	li s0,0xFF200604	# Escolhe o Frame 0 ou 1
	li t2,%frame		# inicio Frame 0
	sw t2,0(s0)
	xori t2,t2,0x001
.end_macro
