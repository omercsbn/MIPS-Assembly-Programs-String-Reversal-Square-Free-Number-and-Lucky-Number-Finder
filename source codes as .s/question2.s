.data
inputyazisi:   .asciiz "\nInput: "
output_prompt:  .asciiz "\nOutput:  "
input:          .space 100
vowel_array: .byte 256

.text
.globl main

main:
    # kullanıcıdan input al.
    li      $v0, 4 # v0'a 4 koduyla string yazdır.
    la      $a0, inputyazisi # input yazısını ekrana bas.
    syscall

    li      $v0, 8 # v0'a 8 ver string oku.
    la      $a0, input # kullanıcıdan aldığın inputu input space'sine yaz.
    li      $a1, 100 # 100lük alan doldur geriye kalanlar 0 doluyor.
    syscall 

    # adresleri yükle, sayacı ayarla, loopa gir.
    la      $t0, input # input stringinin adresini t0'a yükle.
    la      $t4, vowel_array # sesli harf arrayinin adresini t4'e yükle.
    li      $t2, 0 # Sesli harf sayacı
 
loop:
    lb      $t3, ($t0) # kullanıcı inputundan bit bit oku.
    beq     $t3, $zero, adresleriayarla    # null byte, adresleri tekrar ayarlama zamanı.
    beq     $t3, 'a', print_vowel   # a karakteri buldu $t3'de zıpla.
    beq     $t3, 'e', print_vowel   # e karakteri buldu $t3'de zıpla.
    beq     $t3, 'i', print_vowel   # i karakteri buldu $t3'de zıpla.
    beq     $t3, 'o', print_vowel   # o karakteri buldu $t3'de zıpla.
    beq     $t3, 'u', print_vowel   # u karakteri buldu $t3'de zıpla.
    j       next_char               # sesli harf değil sonraki karaktere geç.
print_vowel:
    sb $t3, ($t4)
    addi    $t2, $t2, 1 # sayacı arttır kaç tane sesli sayı var say. aslında düşününce mantıklıydı. sesli harf arrayini tersten okutacaktım. t2*4 bitten sonundan başlayarak başına gidecektim ve tersten yazdıracaktım. olmadı. oldu!!!! evet oldu!!!!
    addi $t4,$t4, 4 #sonraki adrese geç, vowel_arrayinin adresini arttır.
next_char:
    addi    $t0, $t0, 1 # input stringinin bitini 1 arttır sonraki karakter.
    j       loop #loopa geri zıpla.

# Input stringinin sonuna kadar ilerleyin


# ikinci loopa girmeden adresleri ayarla.
adresleriayarla:
la $t4 vowel_array # vowel arrayini t4'e yükle.
la $t0, input # input stringini t0'a yükle.
mul $t2, $t2, 4 #  t2 vowel sayısı adresle çarparsam arrayin son elemanına gidebilirim.

add $t4, $t4, $t2 # t4'ü t2 kadar arttır. arrayin sonuna git sondan başa geleceksin.
j loop3 #tekrardan inputu okuyup harfleri değiştirmek için zıpla.

loop3:
    lb      $t3, ($t0)              # kullanıcı inputundan bit bit oku.
    beq     $t3, $zero, end_loop    # null byte, looptan çıkma zamanı, programa veda.
    beq $t3, 10, end_loop
    beq     $t3, 'a', print_vowel2   # a karakteri buldu $t3'de zıpla.
    beq     $t3, 'e', print_vowel2   # e karakteri buldu $t3'de zıpla.
    beq     $t3, 'i', print_vowel2   # i karakteri buldu $t3'de zıpla.
    beq     $t3, 'o', print_vowel2   # o karakteri buldu $t3'de zıpla.
    beq     $t3, 'u', print_vowel2   # u karakteri buldu $t3'de zıpla.
    j       next_char2               # sesli harf değil sonraki karaktere geç.
print_vowel2:
    subi $t4,$t4, 4 # adresten 4 çıkart vowel arrayden geri gelerek overwrite yapma zamanı.
    lb $t3, ($t4) # vowel arrayinin tersinden aldığın karakteri t3'e koy.
    sb $t3, ($t0) # t3 değerini arraye yaz overwrite yap!
    
    #burada sesli harf sayacı arttırma yok çünkü gerek yok!
    
next_char2:
    addi    $t0, $t0, 1 # input stringinin bitini 1 arttır sonraki karakter.
    li      $v0, 11 # 11: karakter yazdırma sistemi çağrısı
    move    $a0, $t3 # son halini printlemek için her karakteri bas.
    syscall
    j       loop3 # loop3 e geri dön sonraki bit kontrolü.

# koddan çıkma zamanı.
end_loop:

    li      $v0, 10                 # sistem çağrısı 10, programdan çık.
    syscall # bitiş.
