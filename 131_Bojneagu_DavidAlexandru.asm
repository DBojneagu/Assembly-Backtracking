.data
formatPrintf2: .asciz "%d"
formatPrintf: .asciz "%d "   
FormatScanF: .asciz "%1000[^\n]"  
formatprintf9: .asciz "-1 "
formatPrintf3: .asciz "\n"
n: .space 4
m: .space 4
k: .long -1
prod: .space 4
Ninitial: .space 4
str: .space 365
chdelim: .asciz " "
permutare: .space 365
frecv: .space 32 

.text

backtrack:


pushl %ebp
movl %esp, %ebp
pushl %ebx
pushl %esi
pushl %edi

xorl %ecx, %ecx


start: 
 cmp n, %ecx 
 jg sfarsit
 
 
movl %ecx, %ebx
cmp $0, (%edi, %ecx,4)
je adauga


incl %ecx
movl %ecx, %ebx
jmp start


adauga:
xorl %edx, %edx 

movl (%edi, %ecx, 4), %eax


jmp altnumar

altnumar:
movl %ebx, %ecx 
xorl %edx, %edx
incl %eax

cmp Ninitial, %eax
jg cont_bef_go_back
//else
jmp stanga







prealtnumar:
subl (%edi, %ecx,4), %eax
subl (%edi, %ecx,4), %eax
jmp altnumar








stanga:

cmp m, %edx
je predreapta 


decl %ecx
incl %edx





cmp (%edi, %ecx, 4) , %eax
je altnumar

addl (%edi, %ecx, 4), %eax
addl (%edi, %ecx, 4), %eax 

cmp %eax, (%edi, %ecx, 4)
je prealtnumar

subl (%edi, %ecx,4), %eax
subl (%edi, %ecx,4), %eax


jmp stanga


predreapta:
xorl %edx, %edx
movl %ebx, %ecx 
jmp dreapta

dreapta:

cmp m, %edx
je distantaMparcursa

incl %ecx
incl %edx

cmp n, %ecx
jg distantaMparcursa

cmp n, %ecx
jg distantaMparcursa

cmp (%edi, %ecx, 4) , %eax
je altnumar

addl (%edi, %ecx, 4), %eax
addl (%edi, %ecx, 4), %eax 

cmp %eax, (%edi, %ecx, 4)
je prealtnumar

subl (%edi, %ecx,4), %eax
subl (%edi, %ecx,4), %eax

jmp dreapta


distantaMparcursa:
movl %ebx, %ecx 

movl %eax, %ecx
cmp $3, (%esi, %ecx, 4)
je altnumar

incl (%esi, %ecx, 4)


movl %ebx, %ecx
movl %eax, (%edi, %ecx, 4)


incl %ecx
jmp start


cont_bef_go_back:
movl $0, (%edi, %ecx, 4)
jmp go_back

go_back:
decl %ecx

cmp $0, %ecx
jl sfarsit

movl (%edi, %ecx, 4), %eax
cmp $0, %eax
jl go_back

movl %ecx, %ebx

movl $0, (%edi, %ecx, 4)
decl (%esi, %eax, 4) 
jmp altnumar






sfarsit:

movl %edi, %eax
movl $permutare, %eax
popl %edi
popl %esi
popl %ebx
popl %ebp
ret

.global main

main:

pushl $str
pushl $FormatScanF
call scanf
popl %ebx
popl %ebx


pushl $chdelim
pushl $str
call strtok
popl %ebx
popl %ebx

pushl %eax
call atoi
popl %ebx

movl %eax, n
movl %eax, Ninitial
addl %eax, n
addl %eax, n
decl n

pushl $chdelim
pushl $0
call strtok
popl %ebx
popl %ebx

pushl %eax
call atoi
popl %ebx

movl %eax, m

pushl $chdelim
pushl $0
call strtok
popl %ebx
popl %ebx

pushl %eax
call atoi
popl %ebx

xorl %ecx, %ecx
movl $permutare, %edi
movl $frecv, %esi

pushl %eax
cmp $0, %eax
jge neg1

contneg1:

movl %eax, (%edi, %ecx, 4)

popl %eax
pushl %ecx

movl %eax, %ecx
incl (%esi, %ecx, 4)

popl %ecx 

incl %ecx



et_for:

      pushl %ecx
      
      pushl $chdelim
      pushl $0
      call strtok
      popl %ebx
      popl %ebx
      
      cmp $0, %eax
      je preafisare
      
      pushl %eax
      call atoi
      popl %ebx
      
      popl %ecx
      
      pushl %eax 
      cmp $0, %eax
      jge neg
      
      contneg:
       
      movl %eax, (%edi, %ecx, 4)
      popl %eax 
      pushl %ecx
      
      movl %eax, %ecx
      cmp $0, %ecx
      je skip
      
      incl (%esi, %ecx, 4)
      skip:
      popl %ecx 
            
      incl %ecx
      jmp et_for
      
      


neg: 

movl %eax, %ebx
addl %ebx, %ebx
sub %ebx, %eax
jmp contneg
neg1: 

movl %eax, %ebx
addl %ebx, %ebx
sub %ebx, %eax
jmp contneg1

preafisare:

call backtrack

incl n


cmp $0, %ecx
jl afisarenosol


xorl %ecx, %ecx 
jmp afisare





afisare: 

      
      cmp %ecx, n
      je exit
      
      pushl %ecx
      cmp $0, (%edi, %ecx, 4)
      jl pozitiv
      
      jmp contpoz
      
pozitiv:

      xorl %edx, %edx
      subl (%edi, %ecx, 4), %edx
      movl %edx, (%edi, %ecx, 4)
      
      jmp contpoz

      contpoz:
      pushl (%edi, %ecx, 4)
      pushl $formatPrintf
      call printf
      popl %ebx
      popl %ebx
      
      popl %ecx
      
      incl %ecx
      
      jmp afisare
    
    
afisarenosol:

pushl $formatprintf9
call printf
popl %ebx
jmp exit
    
exit:  
      
      pushl $formatPrintf3
      call printf
      popl %ebx
      
      
      pushl $0
      call fflush
      popl %ebx
      
      movl $1, %eax
      xorl %ebx, %ebx
      int $0x80
