.data 
.include "pikachu_front.data"
.text 
OUT:   
    li a4, 16           # 16x16
    li a3,320           # multiplicar depois
    li t1,0xFF000000    # endereco inicial da Memoria VGA - Frame 0
    li t2,256         # endereco final 
    la s1,pikachu_front        # endere�o dos dados da tela na memoria
    addi s1,s1,8        # primeiro pixels depois das informa��es de nlin ncol
    
CICLO: 
    bge t4,t2,FIM       # Se for o �ltimo endere�o ent�o sai do loop
    addi t0,t0,4	# contador
    addi t4,t4,4
    lw t3,0(s1)         # le um conjunto de 4 pixels : word
    sw t3,0(t1)         # escreve a word na mem�ria VGA   
    addi t1,t1,4        # soma 4 ao endere�o
    addi s1,s1,4
    beq t0,a4,BREAK
    j CICLO   
         
BREAK:
    add t1,t1,a3	#Endere�o +320
    sub t1,t1,t0	#Endere�o - 16
    li t0,0
    j CICLO

FIM:    
    li a7,10        # syscall de exit
    ecall
