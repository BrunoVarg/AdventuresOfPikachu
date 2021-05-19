.text
CLEAN_IMAGE:
	li t4, 0
	li t3, 0
	li t1,0xFF000000	# endereco inicial da Memoria VGA - Frame 0
	bgtz  t0, FRAME1_CI
	j START1_CI
FRAME1_CI:
	li t0, 0x00100000
	add t1,t1,t0
START1_CI:
	 li t0,0
	 li s3,320		# multiplicar depois 
	 li a3,320
	 mul s3, s3, s1		# 320*(Altura) (Y)		
	 li s4, 16		# Largura da Imagem
	 li t2, 256
	 add t1, t1, s3		# Endereço Inicial + 320*(Altura) 
	 add t1, t1, s2		# Endereço Inicial + 320*(Altura) + (Largura)
	 addi a1, a1, 8
	 add a1, a1, s3			
	 add a1, a1, s2       	# primeiro pixels depois das informações de nlin ncol
SAVE_CI: 
	bge t4,t2,FINAL_CI		
	addi t0,t0,4		
	addi t4,t4,4		
	lw t3,0(a1)         
	sw t3,0(t1)         
	addi t1,t1,4        
	addi a1,a1,4	
	beq t0,s4,BREAK1_CI
	j SAVE_CI   
         
BREAK1_CI:
	add t1,t1,a3		#Endereço + 320 = Pula a linha
	add a1,a1,a3
	sub a1,a1,t0
	sub t1,t1,t0		#Endereço - 16 = Diminui pelo tamanho dos pixels
	li t0,0
	j SAVE_CI
FINAL_CI:
	li t4, 0
	ret
	
